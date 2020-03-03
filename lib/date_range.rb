module Hotel
  class DateRange
    attr_accessor :start_date, :end_date

    # Constructor
    def initialize(start_date, end_date)
      unless start_date.instance_of?(Date) && end_date.instance_of?(Date)
        raise ArgumentError, "Parameters must be of class Date"
      end
      if start_date >= end_date
        raise ArgumentError, "Start date must be before end date"
      end
      @start_date = start_date
      @end_date   = end_date
    end

    # Check Range Overlap
    def overlap?(other)
      unless other.instance_of?(Hotel::DateRange)
        raise ArgumentError, "Parameters must be of class Hotel::DateRange"
      end

      return other.start_date < @end_date && other.end_date > @start_date
    end

    # Check Date***?
    def include?(date)
      unless date.instance_of?(Date)
        raise ArgumentError, "Parameters must be of class Date"
      end

      return date >= @start_date && date < @end_date
    end

    # Calculate Number of Nights
    def nights
      return (@end_date - @start_date).to_i
    end

  end
end
