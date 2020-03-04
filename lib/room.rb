
module Hotel
  class Room
    attr_reader :room_nr, :cost 
    def initialize(room_nr, cost = 200) # reservation
      @room_nr = room_nr
      @cost = cost 
    end 

    #Create one method that knows about the reservation
  end
end