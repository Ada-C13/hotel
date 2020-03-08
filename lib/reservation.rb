require 'Date'

module Hotel
  class Reservation 
    attr_accessor :start_date, :end_date, :room, :block_id, :blocks_room_status

    def initialize(start_date, end_date, room, block_id = nil, blocks_room_status = nil)  
     @room = room
     @block_id = block_id
      if start_date.class == String
        start_date = Date.parse(start_date)
      end
      @start_date = start_date

      if end_date.class == String
        end_date = Date.parse(end_date)
      end
      @end_date = end_date

      if @end_date && (@end_date < @start_date)
        raise ArgumentError, "End time cannot be before start time."
      end

      if @end_date && (@end_date == @start_date)
        raise ArgumentError, "You cannot have a 0 length date range."
      end
      @block_id = block_id
      @blocks_room_status = blocks_room_status
    end

    def cost(start_date, end_date)
      cost = DateRange.new(start_date, end_date).nights * 200
      return cost.to_i
    end
  end
end