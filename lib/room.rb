module Hotel
  class Room
    attr_reader :room_num
    attr_accessor :date_range

    def initialize(
      room_num: 

    )

      @room_num = room_num
      @date_range = []
      @cost = 200
    end #initialize end
  end #class Room end
  
end #module Hotel end
