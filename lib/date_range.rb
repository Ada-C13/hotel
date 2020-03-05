require 'Date'

module Hotel
  class DateRange
    attr_accessor :start_date, :end_date

    def initialize(start_date, end_date)
      if start_date.class == String
        start_date = Date.parse(start_date)
      end
      @start_date = start_date

      if end_date.class == String
        end_date = Date.parse(end_date)
      end
      @end_date = end_date

      if @end_date && (@end_date < @start_date)
        raise ArgumentError, "End time cannot be before start time."
      end

      if @end_date && (@end_date == @start_date)
        raise ArgumentError, "You cannot have a 0 length date range."
      end

    end

    def overlap?(test_range)
      if @start_date >= test_range.start_date && 
         @end_date < test_range.end_date #contained range(@range inside test),same
        return true
      elsif @start_date == test_range.end_date #range ending on start date
        return false
      elsif test_range.start_date < @end_date #back overlap
        return true
      elsif @end_date == test_range.start_date #test range starts on end date
        return false
      elsif @start_date <= test_range.start_date && 
        @end_date > test_range.end_date #containing range
        return true
      elsif @start_date > test_range.start_date && 
        @end_date > test_range.end_date #front overlap
        return true
      elsif @start_date == test_range.start_date && 
        @end_date == test_range.end_date #same range
        return true
      else
        return false
      end
    end

    def include?(date)
      return false
    end

    def nights
      nights = (@end_date - @start_date) - 1
      return nights
    end
  end
end