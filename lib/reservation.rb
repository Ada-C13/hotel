module Hotel 
  class Reservation

    PRICE = 200.00

    # date_range is an instance of DateRange class
    # room is an instance of Room class
    attr_reader :date_range, :room

    def initialize(date_range, room)
      @date_range = date_range
      @room = room
    end 
  end 
end 