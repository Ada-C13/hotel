require "date"
require_relative "reservation"

module Hotel
  class DateRange
    attr_reader :start_date, :end_date

    def initialize(start_date, end_date) # (string, string)
      unless start_date <= end_date
        raise ArgumentError.new("End date can't be earlier than start date (got start date: #{start_date} ; end date: #{end_date})")
      end

      # check if the provided start and end dates are both a valid date (ie "2020-01-32")
      first_date = start_date.split("-").map {|item| item.to_i}
      last_date = end_date.split("-").map {|item| item.to_i}
      if !(Date.valid_date?(first_date[0], first_date[1], first_date[2])) || !(Date.valid_date?(last_date[0], last_date[1], last_date[2]))
        raise ArgumentError.new("Date(s) you provided is/are invalid")
      end
      
      @start_date = Date.parse(start_date) 
      @end_date = Date.parse(end_date) 
      
    end

    def nights
      return self.dates_except_last.length
    end

    # list out all the dates of a provided time frame (exclude the last day b/c the room should be able to book by someone else on that day)
    def dates_except_last
      dates = (@start_date..@end_date).map { |each| each }
      dates.pop
      return dates
    end

    def all_dates
      return (@start_date..@end_date).map { |each| each }
    end
    
    def overlap?(other) # (another existing instance of DateRange class)
      (self.dates_except_last).each do |date|
        if (other.dates_except_last).include? date
          return true # return true meaning there is a overlap. Can't book the room.
        end
      end
      return false
    end
  end
end

