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
      unless (@start_date.is_a? Date) && (@end_date.is_a? Date)
        raise ArgumentError.new("Invalid date provided: must be instance of Date")
      end

      if @start_date < Date.today
        raise ArgumentError.new("Invalid date provided: start_date must be prior to today's date")
      elsif @end_date < @start_date
        raise ArgumentError.new("Invalid date provided: end_date must be prior to start_date")
      end
    end

    def overlap?(date_range)
      # if check-out date of one matches check-in date of the other, dates do not overlap
      return false if (@range[-1] == date_range.range[0]) || (@range[0] == date_range.range[-1])

      # if any dates are in both ranges, dates overlap
      return (@range & date_range.range).any? ? true : false
    end
    
  end

end