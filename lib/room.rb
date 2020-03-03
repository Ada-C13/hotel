module Hotel
  class Room
    attr_reader :room_number, :reservations
    attr_accessor :cost

    def initialize(room_number, reservations: [], cost: 200)
      @room_number = room_number
      @reservations = reservations
      # holds collection of reservation objects for this specific room (with dates) - this could be how to check for reservations
      @cost = cost
      
      valid_room_number
    end

    def valid_room_number
      if @room_number.to_i <= 0
        raise ArgumentError, "Invalid Room Number"
      end
    end

  end
end