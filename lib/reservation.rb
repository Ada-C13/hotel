require_relative 'date_range'


module Hotel
  class Reservation < DateRange
    attr_reader :reservation_id, :date_range, :room_number
    
    def initialize(reservation_id, date_range, room_number, price_per_night: 200, total_cost: nil)
      @reservation_id = reservation_id
      valid_reservation_id
      
      @date_range = date_range
      @room_number = room_number # is a string
      # i think this should be the room object
      @price_per_night = price_per_night
      @total_cost = total_cost
    end
    
    
    def total_cost
      total_reservation_cost = @price_per_night * @date_range.num_nights
      
      return total_reservation_cost
    end
    
    
    def valid_reservation_id
      if @reservation_id < 1
        raise ArgumentError.new("Reservation id must be greater than 0")
      end
    end
    
    # adds itself to collection of reservations
    def self.add_reservation

    end
  end
end