require "date"

module Hotel
  class DateRangeError < ArgumentError; end 

  class DateRange
    attr_reader :start_date, :end_date

    def initialize(start_date, end_date)
      @start_date = start_date
      @end_date = end_date

      # Invoke the method
      check_valid_date
    end

    def nights
      return (@end_date - @start_date).to_i
    end

    def include?(date) # search for the specific date
      return @start_date <= date && @end_date > date # excluding end_date
    end


    # Reference: https://makandracards.com/makandra/984-test-if-two-date-ranges-overlap-in-ruby-or-rails
    # @start_date <= other.end_date && @end_date >= other.start_date

    # When booking for the specific date range, check if date range overlaps or not
    def overlap?(other)
      @start_date < other.end_date && @end_date > other.start_date
    end


    private

    def check_valid_date
      if @start_date >= @end_date 
        raise DateRangeError, "An invalid date range"
      end

      range = Date.today..Date.today + (30 * 12)

      if !(range.cover?(@start_date) && range.cover?(@end_date))
        raise DateRangeError, "Date range must be between #{range.first} and #{range.last}"
      end
    end
  end
end
