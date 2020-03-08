require_relative 'date_range'

module Hotel
  class Block
    attr_reader :date_range, :discount_rate
    attr_accessor :rooms, :total_cost
    
    def initialize(date_range, discount_rate, rooms: [])
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
    
    def available?(room_number)
      # invoke find_reservations_by_room
      # invoke find_reservation_block
      # invoke overlap
      # if overlap, raise ArgError
      # else @rooms<<room
    end
    
    
    def total_block_cost
      total_block_cost = @discount_rate * (@date_range.num_nights)
      return total_block_cost
    end
    
  end
end


# First, check that each room that is passed into the rooms array is available for the given date_range

# If they are ALL available, create the instance of the block and shove it into each room's "BLOCK" container

# When we make a new reservation, check not only on overlapping reservations, but also overlapping block dates

# Add the following:
# In list_available_rooms, loop through each room and reject room.blocks == overlap? && ALSO DATERANGE THAT IS NOT AN EXACT MATCH