module Hotel
  class Room
    attr_reader :room_number, :reservations

    def initialize(room_number, reservations: [])
      @room_number = room_number # a string
      @reservations = reservations # reserved dates
      
      valid_room_number
    end

    def valid_room_number
      if @room_number.to_i <= 0
        raise ArgumentError, "Invalid Room Number"
      end
    end

  end
end