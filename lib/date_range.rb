require 'date'

module Hotel
  class DateRange
    attr_accessor :start_date, :end_date

    def initialize(start_date, end_date)
      raise ArgumentError.new("start date has to be at least 1 day before end date") if (end_date - start_date).to_i < 1
      @start_date = start_date
      @end_date = end_date
    end

    def overlap?(other)
      return false
    end

    def include?(date)
      return false
    end

    def nights
      return 3
    end
  end
end