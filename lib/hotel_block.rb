module Hotel
  class HotelBlock
    attr_reader :id, :rooms, :reserved_rooms, :dates

    def initialize(rooms: nil, dates:)
      @id = rand(111111..999999)
      @rooms = rooms if (rooms.class == Array) && (rooms.length >= 1 && rooms.length <= 5)
      @reserved_rooms = []
      @dates = dates
    end

    
  end
end

