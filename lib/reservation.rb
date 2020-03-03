module Hotel
  class Reservation
    attr_reader :range, :room
    ROOM_COST = 200

    # Constructor
    def initialize(start_date, end_date, room)
      @range = Hotel::DateRange.new(start_date, end_date)
      @room  = room
    end

    # Rooms Identical and Cost $200/night
    def cost
      return ROOM_COST * @range.nights
    end
  end
end
