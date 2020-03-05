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

    def add_to_reservation_collection(reservation)
      # @room.add_to_reservation_collection

      # expect to see the reservation object(which in this case is the parameter of the method) added to the room's collection of rooms

      # to test, instantiate a reservation
      # set its room_number to a room
      # add that to the collection of reservations for that room
    end
  end
end