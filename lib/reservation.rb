module Hotel 
  class Reservation

    PRICE = 200.00

    # date_range is an instance of DateRange class
    # room is an instance of Room class
    attr_reader :date_range, :room

    def initialize(date_range, room)
      @date_range = date_range
      @room = room  #room_number TO DO
    end 

    def total_cost 
      return (@date_range.nights * PRICE).to_f.round(2) 
    end 
  end 
end 