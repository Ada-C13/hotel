

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

    def overlap?(other)
      return false
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