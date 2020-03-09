
module Hotel
  class Room
    attr_reader :room_id, :capacity, :cost

    def initialize(room_id, capacity: 2, cost: 200) 
      @room_id = room_id
      @capacity = capacity
      @cost = cost
    end
  end
end
