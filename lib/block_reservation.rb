require "date"
require_relative "date_range"


module Hotel
  class BlockReservation
    attr_reader :id, :date_range, :room_num

    def initialize(date_range, room_num)
      @date_range = date_range
      @room_num = room_num
    end

    def total_price
      # front desk can provide discount price for block reservation. No longer set to $200 fixed price

      # return (@date_range.nights) * 200
    end
  end
end

# I can create a Hotel Block if I give a date range, collection of rooms, and a discounted room rate

# INPUT: date_range, room_nums(array?), discount_rate
# OUTPUT: reserve the block ; return the room# and the 

# reserver the Block by providing date rnage