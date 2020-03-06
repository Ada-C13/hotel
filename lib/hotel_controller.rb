require 'date'

require_relative 'reservation.rb'
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
    end

    def list_rooms
      return @rooms
    end

    def reserve_room(start_date, end_date)
      new_reservation = Reservation.new(start_date, end_date, nil)
      @reservations.push(new_reservation)
      return new_reservation
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

      # @reservations.each do |reservation|
      #   if reservation.date_range.overlap?(requested_range)
      #     avail_rooms.delete_if{|room| room == reservation.room}
      #   end
      # end

      overlapping_reservations = @reservations.select { |res| res.date_range.overlap?(requested_range) }
      overlapping_reservations.each do |res|
        avail_rooms.delete_if { |room| room == res.room }
      end

      return avail_rooms
    end
  end
end