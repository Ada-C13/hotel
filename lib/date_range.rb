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
  end
end