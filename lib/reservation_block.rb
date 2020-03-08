require_relative 'date_range'

module Hotel
  class Block
    attr_reader :date_range, :discount_rate
    attr_accessor :rooms, :total_cost
    
    def initialize(date_range, discount_rate, rooms:)
      @date_range = date_range
      
      @rooms = rooms
      validate_rooms
      
      @discount_rate = discount_rate
      @total_block_cost = total_block_cost
    end
    
    def validate_rooms
      if @rooms.length > 5 || @rooms.length < 2 
        raise ArgumentError.new("You may set aside between 2 & 5 rooms as a block")
      end
    end      
    
    def total_block_cost
      total_block_cost = @discount_rate * (@date_range.num_nights)
      return total_block_cost
    end
    
  end
end