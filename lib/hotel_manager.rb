module Hotel
  class HotelManager
    attr_reader :rooms, :total_reservations

    def initialize
      @rooms = []
      @total_reservations = 0
    end

    def list_rooms
      return @rooms
    end

    def reserve_room(daterange)
      @total_reservations += 1
      return Reservation.new(daterange)
    end
  end
end