require_relative 'room'
require_relative 'reservation'
require_relative 'date_range'
require_relative 'hotel_block'

module HotelBooking
  class FrontDesk
    attr_reader :rooms, :reservations, :hotel_blocks
    def initialize
      @rooms = create_rooms
      @reservations = []
      @hotel_blocks = []
    end

    # make a reservation parent 
    def create_rooms
      created_room = []
      (1..20).each do |x| 
        created_room << Room.new(number: x)
      end 
      return created_room
    end

    def create_hotel_block(date_range, room_count, discount_rate = 1)
      raise ArgumentError.new("there are not #{room_count} rooms available for that time period") if self.available_rooms(date_range).lenght < room_count

      hotel_block = HotelBlock.new(date_range: date_range, room_count: oom_count, discount_rate: discount_rate)

      hotel_blocks << hotel_block

      block_rooms = self.available_rooms(date_range).sample(room_count)
      
      rooms.each do |room|
        if block_rooms.include? (room)
          room.in_block = true
        end
      end

      hotel_block.rooms.push(block_rooms)

      return hotel_block
    end



    def available_rooms(test_range)
      
      overlapping_rooms = @reservations.select do |res|
        res.date_range.overlap?(test_range)
      end.map do |reservation|
        reservation.room
      end

      return @rooms.reject do |room|
        overlapping_rooms.include? room
      end

      # raise ArgumentError.new("No rooms available") if available_rooms.lenght == 0
      # return available_rooms
    end

    def make_reservation(date_range)
      available_room = self.available_rooms(date_range).first
      raise.ArgumentError.new("no rooms available in this date") if available_room.nil? 
      reservation = Reservation.new(date_range: date_range, room: available_room)
      @reservations << reservation
      return reservation
    end
  
    def list_room_reservations(room, test_range)
      return @reservations.select { |reservation| reservation.room == room && reservation.date_range.overlap?(test_range) }
    end

    def make_room_reservation(test_range, room)
      overlapping = self.list_room_reservations(room, test_range)
      if overlapping.length != 0
        raise ArgumentError.new("room not available in that date range")
      else
        new_res = Reservation.new(date_range: test_range, room: room)
        @reservations << new_res
        return new_res
      end
    end

    def list_date_reservations(date)
      date_reservations = []
      @reservations.each do |reservation|
        if reservation.date_range.include?(date)
            date_reservations << reservation
        end
      end
      return date_reservations
    end
   
  end

end
