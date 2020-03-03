
module Hotel
  class Room
    attr_reader :room_number, :reservations
    attr_accessor :cost

    def initialize(room_number, reservations: [], cost: 200)
      @room_number = room_number
      @reservations = reservations
      # holds collection of reservation objects
      @cost = cost
    end

  end
end

