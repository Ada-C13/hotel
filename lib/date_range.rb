require_relative 'date_range'

module Hotel
  class DateRange
    attr_accessor :start_date, :end_date

    def initialize(start_date, end_date)
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

    def overlap?(range)
      if (range.start_date) == @end_date || (range.end_date) == @start_date
        return false
      elsif @start_date.between?(range.start_date, range.end_date) && @end_date.between?(range.start_date, range.end_date)
        return true
      elsif (range.start_date).between?(@start_date, @end_date)
        return true
      elsif @start_date.between?(range.start_date, range.end_date)
        return true
      elsif @end_date.between?(range.start_date, range.end_date)
        return true
      else
        return false
      end
    end

    def include?(date)
      if date > @end_date || date == @end_date || date < @start_date
        return false
      end
      return true
    end

    def nights
      nights = (end_date - start_date) - 1
    end
  end
end