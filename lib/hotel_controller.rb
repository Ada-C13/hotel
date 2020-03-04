require "date"

module Hotel
  class HotelController
    attr_reader :rooms, :reservations

    def initialize(rooms:, reservations:)
      @rooms = (1..20).to_a
      @reservations = []
    end

    def make_reservation(check_in:, check_out:)
      date_range = DateRange.new(check_in: check_in, check_out: check_out)
      room = @rooms.sample
      reservation = Reservation.new(date_range: date_range, room: room)
      @reservations << reservation
      return reservation
    end

    # def find_by_date(reservations)
      # call include? ?
    # end

    # def find_by_date(room, date_range)
      # call include? ?
    # end

    # def find_available_rooms
      # call overlap? ?
    # end

    # def show_all_rooms
      # @rooms.each |room| do puts "room: " room end
    # end

    # show reservation cost (by what? how? reservation id?)

  end
end
