require 'date'

module Hotel
  class DateRange
    attr_reader :check_in, :check_out
    
    # how to validate date input?
    # input should be a string
    # formatted year-mo-day or day-mo-year
    # possible methods: parse, iso8601, strptime
    def initialize(check_in, check_out)
      @check_in = Date.parse(check_in)
      @check_out = Date.parse(check_out)
      
      validate_date_range
    end
    
    def gimme_valid_date_format
      # get date input
      # check against a valid date formatter - e.g. regex or something like that

      # raise and rescue an argument error if the date isn't in a valid format
      # valid formats for date.parse are:
      # "year-month-day"
      # "day-month-year"
    end
    

    def validate_date_range
      if @check_out < @check_in
        raise ArgumentError, "End date cannot be before start date"
      end
    end
    
    
    def num_nights
      num_nights = @check_out.day - @check_in.day
      return num_nights
    end
    
    
    def date_in_range?(date)
      range = @check_in..@check_out
      
      if range.include?(date)
        return true
      else
        return false
      end
    end 
    
  end
end