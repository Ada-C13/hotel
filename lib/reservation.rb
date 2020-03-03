require_relative 'date_range'

module Hotel
  class Reservation < DateRange
    attr_reader :reservation_id, :date_range, :room_number, :total_cost
    
    def initialize(reservation_id, date_range, room_number, price_per_night: 200, total_cost: nil)
      @reservation_id = reservation_id
      @date_range = date_range
      @room_number = room_number
      @price_per_night = price_per_night
      @total_cost = total_cost
    end
    
    def total_cost
    # the total cost is the @price per night times @ number of total nights
    total_reservation_cost = @price_per_night * @date_range.num_nights

    return total_reservation_cost
    end

    def valid_reservation_id
    # is the reservation id valid?
    # if yes, move on
    # if not, raise/rescue an error
    end

  end
end


# validate id number (more than 0, not nil)

# connect to collection of reservations in frontdesk similar to rideshare connect method

# need to somehow account for modify status in available rooms