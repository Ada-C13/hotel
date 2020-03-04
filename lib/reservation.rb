require_relative 'date_range'

module Hotel
  class Reservation
    # Feel free to change this method signature as needed. Make sure to update the tests!
    
    # need reservation id?
    
    attr_reader :start_date, :end_date, :room, :id
    def initialize(start_date, end_date, room, id: nil)
      # reservation has a DateRange - instantiate based on attributes
      # Hotel::DateRange.new(start_date, end_date)
      @start_date = start_date
      @end_date = end_date

      # default room is first available room unless otherwise specified
      # error if room is unavailable - make into another method

      # id = 1 + last trip, access where you store list of reservations

      # instantiate Date.new(@start.....)
    end

    def cost
      return 200
    end
  end
end