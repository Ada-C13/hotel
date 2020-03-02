module Hotel
  class HotelController
    attr_reader :rooms
    def initialize(rooms)
      @rooms = rooms
    end
    
  end
end
