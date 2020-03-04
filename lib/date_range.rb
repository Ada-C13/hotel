require 'date'

module Hotel
  class DateRange
    attr_reader :check_in, :check_out
    
    def initialize(check_in, check_out)
      @check_in = check_in
      @check_out = check_out
      
      validate_date_range 
    end
    
    
    def validate_date_range
      if @check_out < @check_in
        raise ArgumentError, "End date cannot be before start date"
      end
    end
    
    
    def num_nights
      num_nights = (@check_out - @check_in).to_i
      return num_nights
    end  
    
    
    # User story: I can access the list of reservations for a specific date, so that I can track reservations by date
    def date_in_range?(date)
      range = @check_in..@check_out
 
      if date == @check_out
        return false # there are no existing reservations for tonight
      elsif range.include?(date)
        return true # there is an existing reservation for tonight
      else
        return false # there are no existing reservations for tonight
      end
    end 
    
    # this method compares ANOTHER date range to the CURRENT daterange
    def overlap?(other_date_range)
      if other_date_range.check_in < @check_out && @check_in < other_date_range.check_out
        return true # there is an overlap - don't make a rez
      end
      return false # there is no overlap - make a rez
    end
  end
end