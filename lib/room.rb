module Hotel
  class Room
    attr_reader :number

    def initialize(number)
      if number > 20 || number < 1
        raise ArgumentError.new("There are only 20 rooms in this hotel")
      end
      @number = number
    end

    # Methods that will help to compare 2 arrays of Room instances
    def ==(other)
      return number == other.number
    end

    def eql?(other)
      self == other
    end

    def hash
      return number.hash
    end
  end
end