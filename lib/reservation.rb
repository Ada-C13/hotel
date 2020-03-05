module HotelBooking
  class Reservation
    attr_reader :date_range, :room
    def initialize(date_range:, room:) 
      @date_range = date_range
      @room = room
    end

    def cost
      return self.date_range.nights * self.room.cost
    end

  end
end