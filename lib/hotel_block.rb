module Hotel
  class HotelBlock
    attr_reader :id, :rooms, :dates, :discount
    attr_accessor :reservations

    def initialize(rooms, check_in_time, check_out_time, discount: 0.2)
      @id = rand(111111..999999)
      @rooms = rooms if (rooms.class == Array) && (rooms.length >= 1 && rooms.length <= 5)
      @reservations = []
      @dates = Hotel::DateRange.new(check_in_time, check_out_time)
      @discount = discount
    
      if (!(rooms.length > 0) || !(rooms.length < 6)) || rooms.class != Array
        raise ArgumentError, "We can only block 1 to 5 rooms at this time. You tried to block #{rooms.length}."
      elsif (rooms.select { |room| room.class == Hotel::Room }).length != rooms.length
        raise ArgumentError, "Non-Room objects given as arguments"
      end
    end

    def cost(room)
      room_cost = (room.cost - (room.cost * discount)) * dates.nights
      return room_cost.round(2)
    end

    def available_rooms
      unavail = reservations.map { |res| res.room }
      return rooms.difference(unavail)
    end
  end
end

