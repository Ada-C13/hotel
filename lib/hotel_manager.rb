module Hotel
  class HotelManager
    attr_reader :rooms

    def initialize
      @rooms = []
    end

    def list_rooms
      return @rooms
    end

  end
end