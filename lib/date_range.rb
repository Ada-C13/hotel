require 'date'

module Hotel
  class DateRange
    attr_reader :check_in, :check_out
    
    def initialize(check_in, check_out)
      @check_in = Date.parse(check_in)
      @check_out = Date.parse(check_out)
      
      validate_date_range
      # validate_checkin    
    end
    
  
    # def validate_checkin
    #   if @check_in < Date.today
    #     raise ArgumentError, "Reservations must be made in the future."
    #   end
    # end


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