module Hotel
  class Reservation < DateRange
    attr_reader :room_num, :nights, :total_cost, :block_id

    def initialize(arrive, depart, room, block_id = nil)
      super(arrive, depart)
      @room_num = room.room_num
      @nights = nights
      @total_cost = @nights * room.rate
      @block_id = block_id
    end

    def nights
      @depart - @arrive
    end

  end
end