module Hotel
  class Room
    attr_reader :room_num, :cost
    attr_accessor :reserved_dates

    def initialize(
      room_num:, 
      cost: 200, 
      reserved_dates:
    )

      @room_num = room_num
      @cost = cost
      @reserved_dates = reserved_dates || []

    end
  end
end
