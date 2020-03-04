module Hotel
  class Room
    def initialize(id, cost)
      @id = id unless id.class != Integer
      @cost = cost unless cost.class != Integer
    end
  end
end