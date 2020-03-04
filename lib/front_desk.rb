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
      return @reservations.find_all{ |reservation| reservation.start_date <= check_date && reservation.end_date >= check_date}
    end

    def get_range_bookings(start,finish)
      range_start = Date.parse(start)
      range_end = Date.parse(finish)
      raise ArgumentError, "Date range is invalid" if range_end < range_start
      return @reservations.find_all{ |reservation| 
        reservation.start_date <= range_start && reservation.end_date >= range_start ||
        reservation.start_date <= range_end && reservation.end_date >= range_end ||
        reservation.start_date >= range_start && reservation.end_date <= range_end}
    end

    def get_room_bookings(number, start, finish)
      range_bookings = get_range_bookings(start, finish)
      return range_bookings.find_all{ |reservation| reservation.room.number == number }
    end

    def get_reserved_rooms(start, finish)
      range_bookings = get_range_bookings(start, finish)
      reserved_rooms = range_bookings.map do |reservation|
        reservation.room
      end
      return reserved_rooms
    end

    def get_available_rooms(start, finish)
      reserved_rooms = get_reserved_rooms(start, finish)
      available_rooms = @rooms - reserved_rooms
      return available_rooms
    end

    def reserve_room(start, finish)
      available_rooms = get_available_rooms(start, finish)
      raise ArgumentError, "No available rooms for this date range" if available_rooms.empty?
      new_reservation = Reservation.new(room: available_rooms.first, start_date: start, end_date: finish)
      add_reservation(new_reservation)
      return new_reservation
    end
  end
end
