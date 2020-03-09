require 'date'

module Hotel
  class DateRange

    #start_date and #end_date are required to be date objects
    attr_reader :start_date, :end_date
    def initialize(start_date, end_date)
      @start_date = start_date
      @end_date = end_date
      
      raise ArgumentError.new("Must be Date objects") if start_date.class != Date || end_date.class != Date
      raise ArgumentError.new("Start date must come before end date") if (start_date > end_date)
    end

    def overlap?(comparison_range)
      if comparison_range.start_date >= self.start_date && comparison_range.start_date < self.end_date
        return true
      elsif comparison_range.end_date <= self.end_date && comparison_range.end_date > self.start_date
        return true
      elsif comparison_range.start_date <= self.start_date && comparison_range.end_date >= self.end_date
        return true
      else
        return false
      end
    end

  end
end
