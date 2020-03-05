require_relative 'room'
require_relative 'reservation'

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
      reservation.date_range.start_date <= check_date && 
      reservation.date_range.end_date >= check_date}
    end

    def get_range_bookings(range)
      return @reservations.find_all{ |reservation| 
        reservation.date_range.overlap?(range)}
    end

    def get_room_bookings(number, range)
      range_bookings = get_range_bookings(range)
      return range_bookings.find_all{ |reservation| reservation.room.number == number }
    end

    def get_reserved_rooms(range)
      range_bookings = get_range_bookings(range)
      reserved_rooms = range_bookings.map do |reservation|
        reservation.room
      end
      return reserved_rooms
    end

    def get_available_rooms(range)
      reserved_rooms = get_reserved_rooms(range)
      available_rooms = @rooms - reserved_rooms
      return available_rooms
    end

    def reserve_room(range)
      available_rooms = get_available_rooms(range)
      raise ArgumentError, "No available rooms for this date range" if available_rooms.empty?
      new_reservation = Reservation.new(room: available_rooms.first, start_date: start, end_date: finish)
      add_reservation(new_reservation)
      return new_reservation
    end
  end
end
