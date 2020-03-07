module HotelBooking
  class Reservation
    attr_reader :date_range, :room, :block
    def initialize(date_range:, room:, block: nil) 
      @date_range = date_range
      @room = room
      @block = block
    end

    def cost
      if @room.in_block == true
        return self.date_range.nights * ( self.room.cost * self.block.discount_rate )
      else
        return self.date_range.nights * self.room.cost
      end
    end

  end
end