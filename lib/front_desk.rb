require_relative 'room'
require_relative 'reservation'
require_relative 'date_range'

module Hotel
  class FrontDesk
    attr_reader :rooms, :reservations

    def initialize
      @rooms = []
      20.times do |i|
        @rooms << Room.new(i+1)
      end
      @reservations = []
    end

    def get_bookings(date)
      check_date = Date.parse(date)
      return @reservations.find_all{ |reservation| 
        reservation.date_range.includes?(date)
      }
    end

    def get_range_bookings(range)
      return @reservations.find_all{ |reservation| 
        reservation.date_range.overlap?(range)}
    end

    def get_room_bookings(number, range)
      range_bookings = get_range_bookings(range)
      return range_bookings.find_all{ |reservation| 
        reservation.rooms.each do |room|
          room.number == number
        end }
    end

    def get_reserved_rooms(range)
      bookings = get_range_bookings(range)
      reserved_rooms = bookings.map do |reservation|
        reservation.rooms
      end
      return reserved_rooms.flatten
    end

    def get_available_rooms(range)
      reserved_rooms = get_reserved_rooms(range)
      available_rooms = @rooms - reserved_rooms
      raise ArgumentError, "No available rooms for this date range" if available_rooms.empty?
      return available_rooms
    end

    def reserve_room(range)
      available_room = [get_available_rooms(range).first]
      new_reservation = Reservation.new(rooms: available_room, date_range: range)
      @reservations << new_reservation
      return new_reservation
    end

    def reserve_block(range, rooms_count, discounted_rate)
      available_rooms = get_available_rooms(range)
      raise ArgumentError, "Not enough rooms available" if available_rooms.size < rooms_count
      rooms = available_rooms[0..(rooms_count-1)]
      new_block = HotelBlock.new(
        rooms: rooms, 
        date_range: range, 
        discounted_rate: discounted_rate)
      @reservations << new_block
      return new_block
    end
  end
end
