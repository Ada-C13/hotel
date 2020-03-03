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

    def get_room_bookings(number, start, finish)
      range_start = Date.parse(start)
      range_end = Date.parse(finish)
      raise ArgumentError, "Date range is invalid" if range_end < range_start
      return @reservations.find_all{ |reservation| reservation.room.number == number &&
        (reservation.start_date <= range_start && reservation.end_date >= range_start ||
        reservation.start_date <= range_end && reservation.end_date >= range_end ||
        reservation.start_date >= range_start && reservation.end_date <= range_end)}
    end
  end
end
