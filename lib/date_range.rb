require 'date'

module Hotel
  class DateRange
    attr_reader :check_in, :check_out
    
    def initialize(check_in, check_out)
      @check_in = Date.parse(check_in)
      @check_out = Date.parse(check_out)
      
      validate_date_range 
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
        return true # true means there is an existing reservation
      else
        return false # false means there is no existing reservation
      end
    end 
    
  end
end


# This is tricky because tests have past dates in them
# def validate_checkin
#   if @check_in < Date.today
#     raise ArgumentError, "Check-in date cannot be in the past."
#   end
# end