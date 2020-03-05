module Hotel
  class Room
    attr_reader :room_number, :reservations

    def initialize(room_number, reservations: [])
      @room_number = room_number
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

# def room_available?(date)
      
# end
# given a date
# looks at the collection of reservations
# returns false if given date is within any reserved date