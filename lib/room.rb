module Hotel
  class Room
    attr_reader :room_number, :cost
    attr_accessor :reservations_for_room

    def initialize(room_number, cost: 200)
      raise ArgumentError if room_number.class != Integer
      @room_number = room_number
      @cost = cost
      @reservations_for_room = []
    end

  end
end