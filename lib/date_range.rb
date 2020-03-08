module Hotel
  class DateRange
    attr_reader :start_date, :end_date

    def initialize(start_date, end_date)
      if !(start_date.is_a? Date) || !(end_date.is_a? Date)
        raise ArgumentError.new("Invalid data type for either start or end dates.
          Both start and end dates must be of type Date.")
      end

      if end_date < start_date
        raise ArgumentError.new("Invalid date range: start: #{start_date}, end: #{end_date}. 
          End date cannot be less than the start date.")
      end

      @start_date = start_date
      @end_date = end_date
    end

    def nights
      return (@end_date - @start_date).to_i
    end

    def overlap?(other)
      if !other.is_a? Hotel::DateRange
        raise ArgumentError.new("Invalid argument #{other}. Must be of type Hotel::DateRange")
      end

      if other.start_date >= @end_date
        return false
      elsif other.end_date <= @start_date
        return false
      else
        return true
      end
    end
   
    def equals?(other)
      @start_date == other.start_date && @end_date == other.end_date
    end
  end
end