require 'date_range'
require 'reservation'

module Hotel
  class FrontDesk
    attr_accessor :reservations, :rooms 
    def initialize(reservations:nil ,rooms:nil)
      @reservations = reservations || []
      @rooms = {:1 => [],:2 =>[],:3=>[]}
    end

    #access a list of all rooms in hotel
    #access a list of reservations for a specific room number and date range
    # check reservations of specific date
    




    #request reservation 
    # input of start/end
    # check availability
    # assgin room and store info
    # confirm reservation to add 

    

    #reservation_cost method 
    def reservation_cost(reservation)
      looked_up_reservation = @reservations.select {|bookings| reservation==bookings}
      cost = looked_up_reservation[0].date_range.duration
      return cost*200
    end 


    
  end 
end