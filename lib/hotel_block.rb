module Hotel
  class HotelBlock
    attr_reader :block_count, :date_range, :discount_cost
    attr_accessor :rooms

    def initialize(block_count:, date_range:, discount_cost:)
      @block_count = block_count # I interpreted the user story "collection of rooms" to mean I can pass it a 
      #count and the count determines how many rooms to request for the block.
      @date_range = date_range
      @discount_cost = discount_cost
      @rooms = []

      raise ArgumentError.new("Block count must be an integer between 2 and 5 inclusive") if @block_count.between?(2,5) == false

    end

  end

end

#raises an exception if you try and add a reservation using FrontDesk's method
      #for adding reservations
      #takes list of available rooms for the date_range that is passed in that is not already in a block
        #if no available rooms/no enough rooms are available to fill block raise the exception that there are none.
      #pulls out how many rooms are requested for the block (between 2-5)
      #from the block_count that was passed in
      # assaigns the discounted cost to the cost of each room
      #returns that collection of available rooms w/ new discounted price