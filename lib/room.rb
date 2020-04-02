module Hotel
  class Room
    attr_reader :num, :cost

    def initialize(num: nil, cost: 200.00)
      @num = num
      @cost = cost
    end
  end
end
