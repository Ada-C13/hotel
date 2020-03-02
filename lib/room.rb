module Hotel
  class Room
    attr_reader :number, :cost
    attr_accessor :reservations

    def initialize(number, cost: 200, reservations: nil)
      if number > 20 || number < 1
        raise ArgumentError.new("There are only 20 rooms in this hotel")
      end
      @number = number
      @cost = cost
      @reservations = reservations || []
    end
  end
end