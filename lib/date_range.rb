require 'date'

module Hotel
  class DateRange
    attr_accessor :start_date, :end_date

    def initialize(start_date, end_date)
      @start_date = start_date
      @end_date = end_date

      if @start_date >= @end_date || @start_date && end_date == nil
        raise ArgumentError
    end
  end

    def length_of_stay
      return (@end_date - @start_date) - 1
    end

    def overlap?(range)
      if @start_date >= range.end_date || @end_date <= range.start_date
        return false
      else
        return true
      end
    end
  end
end