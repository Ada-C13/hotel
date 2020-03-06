require_relative 'date_range'

module Hotel
  class Reservation < DateRange
    # Feel free to change this method signature as needed. Make sure to update the tests!
    
    # need reservation id?
    
    attr_reader :start_date, :end_date
    def initialize(start_date, end_date)
      # reservation is a DateRange - instantiate based on attributes

      difference = end_date - start_date
      
      if difference == 0
        raise ArgumentError, "Cannot have 0 length date range"
      elsif difference < 0
        raise ArgumentError, "Cannot have negative length for a date range"
      else
        @start_date = start_date
        @end_date = end_date
      end

      # default room is first available room unless otherwise specified
      # error if room is unavailable - make into another method

      # id = 1 + last trip, access where you store list of reservations

      # instantiate Date.new(@start.....)
    end

    def cost
      cost = ((@end_date - @start_date) - 1) * 200
      return cost
    end
  end
end