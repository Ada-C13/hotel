require_relative "date_range"

module Hotel
  class Reservation
    attr_reader :room, :date_range

    def initialize(date_range:, room: nil)
      @room = room
      @date_range = date_range
  
    end


    # ! TODO How to get nights from date_range ?
    # User: I can get the total cost for a given reservation
    def cost(reservation)
      room_rate = 200
      cost = reservation.date_range.nights * room_rate
      return cost
    end
  end
end
