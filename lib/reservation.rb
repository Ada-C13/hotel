module Hotel
  class Reservation < DateRange
    attr_reader :room_num, :nights, :total_cost

    def initialize(arrive, depart, room)
      super(arrive, depart)
      @room_num = room.room_num
      @nights = nights
      @total_cost = @nights * room.rate
    end

    def nights
      @depart - @arrive
    end

  end
end