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

    def add_reservation(reservation)
      @reservations << reservation
    end

    def get_bookings(date)
      check_date = Date.parse(date)
      return @reservations.find_all{ |reservation| 
      reservation.date_range.includes?(date)}
    end

    def get_range_bookings(range)
      return @reservations.find_all{ |reservation| 
        reservation.date_range.overlap?(range)}
    end

    def get_room_bookings(number, range)
      room_bookings = []
      range_bookings = get_range_bookings(range)
      range_bookings.each do |reservation|
        rooms = reservation.rooms.find_all{ |room| room.number == number }
        if rooms.length > 0
        room_bookings << reservation
        end
      end
      return room_bookings
    end

    def get_reserved_rooms(range)
      range_bookings = get_range_bookings(range)
      reserved_rooms = range_bookings.map do |reservation|
        reservation.rooms
      end
      return reserved_rooms.flatten
    end

    def get_available_rooms(range)
      reserved_rooms = get_reserved_rooms(range)
      available_rooms = @rooms - reserved_rooms
      return available_rooms
    end

    def reserve_room(range)
      available_rooms = get_available_rooms(range)
      raise ArgumentError, "No available rooms for this date range" if available_rooms.empty?
      new_reservation = Reservation.new(room: available_rooms.first, date_range: range)
      add_reservation(new_reservation)
      return new_reservation
    end
  end
end
