require 'date'

module Hotel
  class DateRange
    attr_reader :start_date, :end_date

    def initialize(start_date, end_date)
      @start_date = start_date
      @end_date = end_date
 
    end

    def overlap?(other)
      # check to see if the date range itself is overlapping with "other"?
      if self.start_date.between?(other.start_date, other.end_date - 1) || other.start_date.between?(self.start_date, self.end_date - 1)
        return true
      else
        return false
      end
    end

    def include?(date)
      # see if the date provided is in between the date range
      if date.between?(self.start_date, self.end_date - 1)
        return true
      else
        return false
      end 
    end  
  
    def duration  
      return @end_date - @start_date
    end
  end
end