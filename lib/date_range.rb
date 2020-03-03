require 'date'

module Hotel
  class DateRange
    
    attr_accessor :start_date, :end_date

    # your library code should assume that it's receiving Date objects to start
    def initialize(start_date, end_date)
      raise ArgumentError.new("Please pass in Date class instances.") if !(start_date.is_a? Date) || !(end_date.is_a? Date)
      raise ArgumentError.new("Live in the present! Dates should not be prior to today.") if start_date < Date.today
      raise ArgumentError.new("End date should not be earlier than or the same day as start date.")  if end_date <= start_date
      
      @start_date = start_date
      @end_date = end_date
    end

    def count_nights
      nights = (@end_date - @start_date).to_i
      return nights
    end

    def including(other_range)
      if other_range.start_date >= @start_date && other_range.end_date <= @end_date
        return true
      else
        return false
      end
    end

    def overlapping(other_range)
      if other_range.start_date < @end_date && @start_date < other_range.end_date
        return true
      else
        return false
      end
    end

  end
end
