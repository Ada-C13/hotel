require_relative 'date_range'

module Hotel
  class Reservation < DateRange
    attr_reader :reservation_id, :date_range, :room_number, :total_cost
    
    def initialize(reservation_id, date_range, room_number, total_cost: nil)
      @reservation_id = reservation_id
      @date_range = date_range
      @room_number = room_number
      # @total_cost = #INVOKE TOTAL COST METHOD
    end
    
  end
end


# def total_cost
# initialize with reservation_id, check_in, check_out, room_number, total_cost: nil

# validate id number (more than 0, not nil)

# connect to collection of reservations in frontdesk similar to rideshare connect method

# need to somehow account for modify status in available rooms