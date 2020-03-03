require 'date'

module Hotel
  class DateRange
    attr_reader :start_date, :end_date, :range

    def initialize(start_date, end_date)
      @start_date = start_date
      @end_date = end_date
    end

    def total_nights
      return @end_date - @start_date
    end

    def validate_date
      if (!@start_date.is_a? Date) || (!@end_date.is_a? Date)
        raise ArgumentError.new("Invalid date provided: must be instance of Date")
      end

      if @start_date < Date.today
        raise ArgumentError.new("Invalid date provided: start_date must be prior to today's date")
      elsif @end_date < @start_date
        raise ArgumentError.new("Invalid date provided: end_date must be prior to start_date")
      end
      return true
    end
  end
end