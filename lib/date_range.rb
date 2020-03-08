module Hotel

  class DateRange
    # Generator
    attr_accessor :start_date, :end_date

    # Constructor
    def initialize(start_date, end_date)
      # Raise an error when an invalid date range is provided
      unless start_date.instance_of?(Date) && end_date.instance_of?(Date)
        raise ArgumentError, "Parameters must be of class Date"
      end
      if start_date >= end_date
        raise ArgumentError, "Start date must be before end date"
      end
      @start_date = start_date
      @end_date   = end_date
    end

    # Check range overlap
    def overlap?(other)
      unless other.instance_of?(Hotel::DateRange)
        raise ArgumentError, "Parameters must be of class Hotel::DateRange"
      end

      return other.start_date < @end_date && other.end_date > @start_date
    end

    # Check if a date is included in the date range
    def include?(date)
      unless date.instance_of?(Date)
        raise ArgumentError, "Parameters must be of class Date"
      end

      return date >= @start_date && date < @end_date
    end

    # Calculate number of nights
    # Checkout day not to be charged
    def nights
      return (@end_date - @start_date).to_i
    end

  end
  
end
