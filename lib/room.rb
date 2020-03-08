module Hotel
  class Room
    attr_reader :room_number, :cost

    def initialize(room_number, cost: 200)
      raise ArgumentError if room_number.class != Integer
      @room_number = room_number
      @cost = cost
    end

  end
end