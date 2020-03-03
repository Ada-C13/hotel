require 'date'

module Hotel
  class FrontDesk
    attr_reader :reservations
    attr_accessor :rooms

    def initialize
      @rooms = {} # how to store room info??
      @reservations = [] # store reservations
    end

    # List all reservations

    # List all rooms

    # List all available rooms for a given date range

    # Reserve room status (calls "Modify status from reservation")

    #method to add something to the collection of reservations (invoked in reservation)

    # room available?  given the start_date, invoke date_in_range from DateRange - if true, make reservation, if false, raise ArgError (or whatever they say to do)



  end
end