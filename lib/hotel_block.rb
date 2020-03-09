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
