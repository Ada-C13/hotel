module Hotel
  class DateRange

    attr_accessor :start_date, :end_date

    def initialize(start_date, end_date)
      @start_date = start_date
      @end_date = end_date
        if @end_date <= @start_date
          raise DateError "Invalid date. Your start date cannot be after your end date."  
        end
    end
    
    # checks if a reservation overlaps with another
    def overlap?(date_range)
      if (end_date < date_range.start_date || start_date > date_range.end_date)
        return false
      else
        return true
      end
    end

    # checks if date is included in a reservation
    def include?(date) 
      if date >= start_date && date <= end_date
        return true
      else 
        return false 
      end
    end
    
    # find the total of nights stayed
    def nights
      length_of_stay = (@end_date - @start_date).to_i
      return length_of_stay
    end
  end
end
