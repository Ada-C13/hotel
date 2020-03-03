require_relative 'room'
require_relative 'reservation'


module HotelBooking
  class FrontDesk
    attr_reader :rooms, :reservations
    def initialize
    @rooms = []
    @reservations = []
    # @date_range = nil - not sure if we need this yet
    # I want exception raised when an invalid date range is provided, so that I can't make a reservation for an invalid date range
    end

    # I can access the list of all of the rooms in the hotel
  
    # I access the list of reservations for a specified room and a given date range

    def reserve_room(start_date, end_date)
      # start_date and end_date should be instances of class Date
      return Reservation.new(start_date, end_date, nil)
        # I want exception raised when an invalid date range is provided, so that I can't make a reservation for an invalid date range
    end

    # I can access the list of reservations for a specific date, so that I can track reservations by date
    # def reservations(date)
    #   return []
    # end
  

    def available_rooms(start_date, end_date)
      # start_date and end_date should be instances of class Date
      return []
    end
  end

end
