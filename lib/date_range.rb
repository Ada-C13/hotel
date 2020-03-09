require "date"

module Hotel
  class DateRange
    attr_reader :start_date, :end_date

    def initialize(start_date, end_date) # (string, string)
      unless start_date <= end_date
        raise ArgumentError.new("End date can't be earlier than start date (got start date: #{start_date} ; end date: #{end_date})")
      end
      date_validation(start_date, end_date)
      @start_date = Date.parse(start_date) 
      @end_date = Date.parse(end_date) 
    end

    # check if the provided start and end dates are both a valid date (ie "2020-01-32")
    def date_validation(start_date, end_date)
     first_date = start_date.split("-").map {|item| item.to_i}
     last_date = end_date.split("-").map {|item| item.to_i}
      if !(Date.valid_date?(first_date[0], first_date[1], first_date[2])) || !(Date.valid_date?(last_date[0], last_date[1], last_date[2]))
        raise ArgumentError.new("Date(s) you provided is/are invalid")
      end
    end

    def nights
      return self.dates_exclude_last.length
    end

    def dates_exclude_last
      return (@start_date...@end_date).map { |each| each }
    end

    def all_dates
      return (@start_date..@end_date).map { |each| each }
    end
    
    # use when booking the room
    def overlap_exclude_last?(other) # (instance)
      (self.dates_exclude_last).each do |date|
        if (other.dates_exclude_last).include? date
          return true
        end
      end
      return false
    end

    # use when checking the room reservation in a date range
    def overlap_include_last?(other) # (instance)
      (self.all_dates).each do |date|
        if (other.all_dates).include? date
          return true 
        end
      end
      return false
    end
  end
end

