require 'date'

module Hotel
  class DateRange
    attr_reader :start_date, :end_date, :range

    def initialize(start_date, end_date)
      @start_date = start_date
      @end_date = end_date
      validate_date()

      @range = (start_date..end_date).to_a
    end

    def total_nights
      return @end_date - @start_date
    end

    def validate_date()
      if (!@start_date.is_a? Date) || (!@end_date.is_a? Date)
        raise ArgumentError.new("Invalid date provided: must be instance of Date")
      end

      if @start_date < Date.today
        raise ArgumentError.new("Invalid date provided: start_date must be prior to today's date")
      elsif @end_date < @start_date
        raise ArgumentError.new("Invalid date provided: end_date must be prior to start_date")
      end
    end

    def overlap?(date_range)
      if (@range & date_range.range).any?
        if (@range[-1] == date_range.range[0]) || (@range[0] == date_range.range[-1])
          return false
        else
          return true
        end
      else
        return false
      end
    end

    def include?(date)
      if @range.include?(date)
        if date == @range[-1]
          return false
        else
          return true
        end
      else
        return false
      end
    end

  end

end