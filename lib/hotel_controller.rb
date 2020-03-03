require "date"

module Hotel
  class HotelController
    attr_reader :rooms, :reservations

    def initialize(rooms:, reservations:)
      @rooms = (1..20).to_a
      @reservations = []
    end

    def make_reservation(start_date, end_date)
      date_range = DateRange.new(start_date, end_date)
      room = self.rooms.sample
      reservation = Reservation.new(date_range: date_range, room: nil) # update
      @reservations << reservation
      return reservation
    end

    # def find_by_date(reservations)
    # end

    # def find_by_date(room, date_range)
    # end

    # def find_available_rooms
    # end

  end
end
