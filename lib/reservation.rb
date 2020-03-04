module Hotel
  class Reservation
    def initialize(start_date, end_date, room)
      # raise ArgumentError.new("room must be an instance of room") if room.class != Hotel::Room
      @start_date = start_date
      @end_date = end_date
      @room = room # instance of room class
      @date_range = Hotel::DateRange.new(start_date, end_date)
    end

    def cost
      return 3
    end
  end
end