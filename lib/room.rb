module Hotel
  class Room
    attr_reader :number

    def initialize(number)
      if number > 20 || number < 1
        raise ArgumentError.new("There are only 20 rooms in this hotel")
      end
      @number = number
    end

    # Methods that help to compare 2 objects of Room class
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