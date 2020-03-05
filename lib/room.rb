module Hotel
  class Room
    attr_reader :cost
    attr_accessor :room_num, :reservations

    def initialize(
      room_num:, 
      reservations: []

    )

      @room_num = room_num
      @cost = 200
      @reservations = reservations

    end #initialize end
  end #class Room end
  
end #module Hotel end


# parse the dates for comparison later