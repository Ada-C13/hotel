module Hotel
  class Block
    attr_reader :range, :rooms, :rate

    # Constructor
    def initialize(start_date, end_date, rooms, rate)
      @range = Hotel::DateRange.new(start_date, end_date)
      raise ArgumentError, "Rooms must be an array" unless rooms.instance_of?(Array)
      raise ArgumentError, "No more than 5 rooms per block" if rooms.size > 5 
      @rooms = rooms
      raise ArgumentError, "Rate must be a number" unless rate.is_a?(Numeric)
      raise ArgumentError, "Rate must be a positive number" if rate < 0
      @rate  = rate
    end

    def cost
      return @rate * @range.nights * @rooms.size
    end
  end
end

## Hotel Block
# I can create a Hotel Block if I give a date range, collection of rooms, and a discounted room rate
# A block can contain a maximum of 5 rooms

## Hotel Controller
# I want an exception raised if I try to create a Hotel Block and at least one of the rooms is unavailable for the given date range
# Given a specific date, and that a room is set aside in a hotel block for that specific date, I cannot reserve that specific room for that specific date, because it is unavailable
# Given a specific date, and that a room is set aside in a hotel block for that specific date, I cannot create another hotel block that includes that specific room for that specific date, because it is unavailable
# I can check whether a given block has any rooms available
# I can reserve a specific room from a hotel block
# I can only reserve that room from a hotel block for the full duration of the block
# I can see a reservation made from a hotel block from the list of reservations for that date (see wave 1 requirements)
# When a room is reserved from a block of rooms, the reservation dates will always match the date range of the block
# All of the availability checking logic from Wave 2 should now respect room blocks as well as individual reservations