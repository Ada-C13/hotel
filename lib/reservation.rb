require 'awesome_print'
require 'date'

module Hotel
    class Reservation
    attr_reader :reservation_id, :check_in, :check_out :number_of_days, :status, :room_id

    def initialize(reservation_id, check_in, check_out, number_of_days, status, room_id)
        @reservation_id = reservation_id
        @check_in = check_in
        @check_out = check_out
        @number_of_days = number_of_days
        @status = [:open, :denied, :booked]
        @room_id = room_id
    end

    end

end

#*****************
#Methods 

# def add_reservation(reservation)
  
# end

# def delete_reservation(reservation)
  
# end

# def is_available(start_date, number_of_days)
  
# end

# def next_available
  
# end

# def get_reservation (date)
  
# end

