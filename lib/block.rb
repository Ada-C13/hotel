module Hotel

  class Block
    # Generator
    attr_reader :range, :rooms, :rate

    # Constructor
    def initialize(start_date, end_date, rooms, rate)
      @range = Hotel::DateRange.new(start_date, end_date)
      raise ArgumentError, "Rooms must be an array" unless rooms.instance_of?(Array)
      raise ArgumentError, "No more than 5 rooms per block" if rooms.size > 5
      raise ArgumentError, "At least one room per block" if rooms.size == 0
      @rooms = rooms
      raise ArgumentError, "Rate must be a number" unless rate.is_a?(Numeric)
      raise ArgumentError, "Rate must be a positive number" if rate < 0
      @rate  = rate
    end

    # Calculate cost
    def cost
      return @rate * @range.nights * @rooms.size
    end
  end

end

## Hotel Block
# I can create a Hotel Block if I give a date range, collection of rooms, and a discounted room rate
# A block can contain a maximum of 5 rooms