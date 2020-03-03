
module Hotel
  class Room
    attr_reader :room_id, :capacity, :cost

    def initialize(room_id, capacity: 2, cost: 200) 
      @room_id = room_id
      @capacity = capacity
      @cost = cost
    end

    def cost
      return @cost
    end
  end
end

# a = Hotel::Room.new(1)
# p a.cost
