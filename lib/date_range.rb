require "date"
require_relative "reservation"

module Hotel
  class DateRange
    attr_reader :start_date, :end_date

    def initialize(start_date, end_date) # (string, string)
      unless start_date <= end_date
        raise ArgumentError.new("End date can't be earlier than start date (got start date: #{start_date} ; end date: #{end_date})")
      end
      
      @start_date = Date.parse(start_date) 
      @end_date = Date.parse(end_date) 
    end

    # tell how many days there are in a provided time frame
    def duration
      return @end_date - @start_date
    end

    # list out all the dates of a provided time frame
    # this method can be used by the FrontDesk when checking the availability of rooms
    def all_dates
      return (@start_date..@end_date).map {|each| each}
    end

    # check if the provided start and end dates are both a "real" date"
    # this method can be used by the FrontDesk when checking the availability of rooms
    # def date_validation
    #   reture true if @start_date.valid_date? && @end_date.valid_date?
    # end

    # def overlap?(other)
    #   return false
    # end

  end
end

