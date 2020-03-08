
module Hotel
  class Room
    attr_reader :room_nr, :cost 
    def initialize(room_nr, cost = 200)
      @room_nr = room_nr
      @cost = cost 
    end 
  end

  def ==(other)
    room_nr == other.room_nr
  end

end