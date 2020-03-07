require 'pry'

module Hotel
  class DateRange
    attr_reader :start_date, :end_date

    def initialize(start_date:, end_date:)
      range_start = Date.parse(start_date)
      range_end = Date.parse(end_date)
      raise ArgumentError, "Invalid date range" if range_end <= range_start
      @start_date = range_start
      @end_date = range_end
    end

    def days
      return @end_date - @start_date
    end

    def overlap?(range)
      return self.start_date < range.end_date && self.end_date > range.start_date 
    end

    def includes?(date)
      check_date = Date.parse(date)
      return self.start_date <= check_date && self.end_date > check_date 
    end
  end
end
