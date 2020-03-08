module Hotel
  class HotelBlock
    attr_reader :id, :rooms, :reserved_rooms, :date_range

    def initialize(rooms, date_range)
      @id = rand(111111..999999)
      
      
    end
  end
end

