module Hotel
  class DateRange
    attr_accessor :start_date, :end_date

    def initialize(start_date, end_date)
      # allowing for string inputs for dates
      start_date = parse_start_date(start_date)
      end_date = parse_end_date(end_date)

      # verifying proper date range
      difference = end_date - start_date
      if difference == 0
        raise ArgumentError, "Cannot have 0 length date range"
      elsif difference < 0
        raise ArgumentError, "Cannot have negative length for a date range"
      else
        @start_date = start_date
        @end_date = end_date
      end

      @start_date = start_date
      @end_date = end_date
    end

    # methods to parse date
    def parse_start_date(start_date)
      if start_date.is_a?(String)
        return start_date = Date.parse(start_date)
      else
        return start_date = start_date
      end
    end

    def parse_end_date(end_date)
      if end_date.is_a?(String)
        return end_date = Date.parse(end_date)
      else
        return end_date = end_date
      end
    end

    def overlap?(range)

      return false
    end

    def include?(date)
      return false
    end

    def nights
      nights = (end_date - start_date) - 1
    end
  end
end