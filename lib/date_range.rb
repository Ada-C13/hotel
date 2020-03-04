require 'date'

module Hotel
  class DateRange
    attr_reader :start_date, :end_date

    def initialize(start_date, end_date)
      @start_date = start_date
      @end_date = end_date
 
    end

    def overlap?(other)
      return false
    end

    def include?(date)
      return false
    end

    def duration  
      return @end_date - @start_date
    end
  end
end