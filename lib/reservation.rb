
module Hotel

  class Reservation

    attr_reader :daterange, :room
    
    def initialize(daterange, room)
      @room = room
    end

    def total_cost
      return 2.0
    end
  end
end