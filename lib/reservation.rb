module Hotel
  class Reservation < DateRange
    attr_reader :room_num, :nights, :total_cost, :block

    def initialize(arrive, depart, room, block = nil)
      super(arrive, depart)
      @room_num = room.room_num
      @nights = nights
      @total_cost = get_total_cost(room, block)
      @block = block
    end

    def nights
      @depart - @arrive
    end

    def get_total_cost(room, block)
      if block.nil?
        room.rate * @nights
      else
        block.rate * @nights
      end
    end

  end
end