require "date"
require_relative "reservation"
require_relative "date_range"

module Hotel
  class HotelController
    attr_reader :rooms, :reservations

    def initialize(rooms: (1..20).to_a, reservations: [])
      @rooms = rooms
      @reservations = reservations
    end

    def make_reservation(check_in, check_out)
      date_range = DateRange.new(check_in: check_in, check_out: check_out)
      if @reservations.length > 0
        room = find_available_rooms(check_in, check_out).first
      else
        room = @rooms.first
      end
      reservation = Reservation.new(date_range: date_range, room: room)
      @reservations << reservation
      return reservation
    end

    def find_available_rooms(check_in, check_out)
      new_date_range = DateRange.new(check_in: check_in, check_out: check_out)
      available_rooms = @rooms.clone
      @reservations.each do |reservation|
        if reservation.date_range.overlap?(new_date_range) == true
          available_rooms.delete(reservation.room)
        end
      end
      if available_rooms.length > 0
        return available_rooms
      else
        raise StandardError, "There are no rooms available for those days"
      end
    end

    # def find_by_date(date_range)
    # call include? ?
    # end

    # def find_by_date(room, date_range)
    # call include? ?
    # end

    def show_all_rooms
      return @rooms
    end

    # def show_reservation_cost (reservation) # is this needed/helpful?
    #   return reservation.calculate_cost
    # end
  end
end

# Wave 1:
# I can access the list of all of the rooms in the hotel
# I access the list of reservations for a specified room and a given date range
# I can access the list of reservations for a specific date, so that I can track reservations by date
# I can get the total cost for a given reservation
# I want exception raised when an invalid date range is provided, so that I can't make a reservation for an invalid date range

# Wave 2:
# I can view a list of rooms that are not reserved for a given date range, so that I can see all available rooms for that day
# I can make a reservation of a room for a given date range, and that room will not be part of any other reservation overlapping that date range
# I want an exception raised if I try to reserve a room during a date range when all rooms are reserved, so that I cannot make two reservations for the same room that overlap by date
