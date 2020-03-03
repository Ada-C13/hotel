module Hotel
  class Room
    attr_reader :number

    def initialize(number)
      if number > 20 || number < 1
        raise ArgumentError.new("There are only 20 rooms in this hotel")
      end
      @number = number
    end
  end
end