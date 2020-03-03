
module HotelBooking
  class Reservation
    attr_reader :id, :start_date, :end_date
    def initialize(id:, start_date:, end_date:) 
      # we don'r have room_num as an attribute because When reserving a room, the user provides only the start and end dates - the library should determine which room to use for the reservation
      @id  = id
      @start_date = start_date
      @end_date = end_date
    end



    # I can get the total cost for a given reservation
    #  Every room is identical, and a room always costs $200/night
    #  The last day of a reservation is the checkout day, so the guest should not be charged for that night
    def reservation_cost
    end

  end
end