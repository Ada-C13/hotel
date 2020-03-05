module Hotel
  class FrontDesk 
    attr_reader :reservations
    def initialize
        @rooms = {}
        @reservations = []
    end

    def rooms
      return @rooms.keys
    end

    def reserve_room(start_date, end_date)
    end

  end
end