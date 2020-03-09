module Hotel
  class Room
    attr_reader :id, :cost
    def initialize(id, cost = 200)
      unless id.instance_of?(Integer) && id >0
        raise ArgumentError.new("Id must be a positive integer")
      end
      unless cost.instance_of?(Integer) && cost >= 0
        raise ArgumentError.new("cost must be a positive value")
      end
      @id = id
      @cost = cost
    end
    
    def ==(other)
      self.id == other.id
    end
  end
end