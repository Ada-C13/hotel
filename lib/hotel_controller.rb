require 'date'

require_relative 'reservation.rb'
require_relative 'room_reservation.rb'
require_relative 'date_range.rb'
require_relative 'room.rb'

module Hotel
  class HotelController
    attr_reader :rooms, :reservations

    def initialize
      rooms_array = []
      20.times{ |i| rooms_array.push(Hotel::Room.new(i+1)) }
      @rooms = rooms_array
      @reservations = []
      @blocks = []
    end

    def list_rooms
      return @rooms
    end

    def reserve_room(start_date, end_date, room=@rooms.sample)
      raise RuntimeError.new("room #{room.room_number} isn't available for those dates") unless available_rooms(start_date,end_date).include?(room)

      new_reservation = RoomReservation.new(start_date, end_date, room)
      @reservations.push(new_reservation)
      return new_reservation
    end

    def create_hotel_block(date_range,collection_of_rooms,disc_rate)
      raise ArgumentError.new("A block can only contain up to five rooms") if collection_of_rooms.length > 5


      collection_of_rooms.each do |room|
        raise RuntimeError.new("#{room.room_number} is not available") if available_rooms(date_range.start_date,date_range.end_date).include?(room) == false

        reserve_room(date_range.start_date,date_range.end_date,room)
      end

      new_block = Hotel::Block.new(date_range.start_date, date_range.end_date, collection_of_rooms, disc_rate)

      @blocks.push(new_block)

      return new_block

    end

    def reserve_room_from_block(block,room)
      raise ArgumentError.new("#{room.room_number} is not available") unless block.available_rooms.include?(room)

      block.reserve_room_from_block(room)
    end

    def reservations(date)
      reservations_to_return = []
      @reservations.each do |reservation|
        reservations_to_return.push(reservation) if reservation.date_range.include?(date)
      end

      return reservations_to_return
    end

    def available_rooms(start_date, end_date)
      raise ArgumentError.new("start date has to be at least 1 day before end date") if (end_date - start_date).to_i < 1

      requested_range = Hotel::DateRange.new(start_date,end_date)
      avail_rooms = rooms.clone
      overlapping_reservations = @reservations.select { |res| res.date_range.overlap?(requested_range) }

      overlapping_reservations.each do |res|
        avail_rooms.delete_if { |room| room == res.room }
      end

      return avail_rooms
    end

  end
end