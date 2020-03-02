module Hotel
  class HotelManager
    attr_reader :rooms

    def initialize
      @rooms = []
    end

    def list_rooms
      if @rooms == []
        return nil
      else
        return @rooms
      end
    end
  end
end