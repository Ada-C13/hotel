require_relative 'date_range'

module Hotel
  class Reservation
    attr_reader :date_range
    attr_accessor :room_number
    
    # make room_number optional?
    def initialize(date_range, room_number: nil, price_per_night: 200, total_cost: nil)
      @date_range = date_range
      @room_number = room_number
      # i think this should be the room object
      @price_per_night = price_per_night
      @total_cost = total_cost
    end
    
    # TODO: Method for room number validation - if I try to pass a bad number as a room_number, what will happen
    # TODO: What gets passed as room number when room is instantiated - that is what should be passed to reservation
    
    def total_cost
      total_reservation_cost = @price_per_night * (@date_range.num_nights)
      
      return total_reservation_cost
    end
  end
end