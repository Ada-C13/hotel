module Hotel
  attr_reader :room_id, :rate, :reservations
  
  class Room
    def initialize(room_id)
      @room_id = room_id
      @rate = 200
      @reservations = []
    end

  end
end