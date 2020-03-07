module HotelBooking
  class Reservation
    attr_reader :date_range, :room, :block
    def initialize(date_range:, room:, block: nil) 
      @date_range = date_range
      @room = room
      @block = block
    end

    def cost
      if @room.in_block 
        return @date_range.nights * ( @room.cost * @block.discount_rate )
      else
        return @date_range.nights * @room.cost
      end
    end

  end
end