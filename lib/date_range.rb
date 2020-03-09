require 'date'

module HotelBooking
  class DateRange
    attr_accessor :start_date, :end_date

    def initialize(start_date:, end_date:)
      @start_date = start_date
      @end_date = end_date

      raise ArgumentError.new("Please provide an end date!") if end_date == nil
      raise ArgumentError.new("End date needs to be after start date") if end_date <= start_date
      raise ArgumentError.new("Start date cannot be in the past!") if start_date < Date.today
        
    end

    def overlap?(test_range)
      ts = test_range.start_date
      te = test_range.end_date
      ss = @start_date
      se = @end_date
      if 
        te == ss || 
        ts == se || 
        te < ss || 
        ts > se
        return false
      elsif 
        ((ts == ss) && (te == se)) ||
        ((ts > ss) && (te < se)) || 
        ((ts > ss) && (te > se)) || 
        ((ts < ss) && (te < se)) || 
        ((ts < ss) && (te > se))
        return true
      end
    end

    def include?(date)
      if (date < start_date) || (date >= end_date) 
        return false
      else (date >= start_date) && (date < end_date)
        return true
      end
    end

    def nights
      return (end_date - start_date).to_i
    end

    def ==(other)
      return @start_date == other.start_date && @end_date == other.end_date
    end
  end
end