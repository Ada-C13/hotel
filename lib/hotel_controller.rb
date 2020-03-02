require "date"

module Hotel
  class HotelController
    attr_reader :rooms, :reservations

    def initialize(rooms:, reservations:)
      @rooms = [1..20]
      @reservations = []
    end

    def make_reservation
    end

    # def find_by_date(reservations)
    # end

    # def find_by_date(room, date_range)
    # end

    # def available_rooms
    # end

  end
end
