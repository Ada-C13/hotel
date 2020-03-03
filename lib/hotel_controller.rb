require "date"

module Hotel
  class HotelController
    attr_reader :rooms, :reservations

    def initialize(rooms:, reservations:)
      @rooms = (1..20).to_a
      @reservations = []
    end

    def make_reservation
      date_range = date_range.new(start_date: "2001-02-03", end_date: "2001-02-04") # update
      reservation = Reservation.new(date_range: date_range, cost: nil, room: nil) # update
      @reservations << reservation
      return reservation
    end

    # def find_by_date(reservations)
    # end

    # def find_by_date(room, date_range)
    # end

    # def available_rooms
    # end

  end
end
