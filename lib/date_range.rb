module Hotel 
  class DateRange

    attr_accessor :start_date, :end_date 

    def initialize(start_date:, end_date:)
      if end_date < start_date 
        raise ArgumentError.new("Invalid date range: End date, #{end_date}, is before  start date, #{start_date}")
      elsif end_date == start_date
        raise ArgumentError.new("Invalid date range: start_date and end_date is the same day")
      end 
      @start_date = start_date
      @end_date = end_date
    end 

    def overlap?(other_date_range)
      # same date range
      if @start_date == other_date_range.start_date && @end_date == other_date_range.end_date 
        return true
      # this range starts on or within the other's range 
      elsif @start_date >= other_date_range.start_date && @start_date < other_date_range.end_date # note: start_date == end_date is okay 
        return true 
      # this range ends within the other's range 
      elsif @end_date > other_date_range.start_date && @end_date < other_date_range.end_date
        return true 
      else 
        return false
      end 
    end

    def include?(date)
      if date >= @start_date && date < @end_date
        return true
      end 
      return false
    end

    def nights
      return @end_date - @start_date
    end 
    
  end
end   