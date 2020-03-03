require 'date'
module Hotel
  class InvalidDateRange < StandardError
  end
  class DateRange
    attr_reader :start_date, :end_date, :nights

    def initialize(start_date, end_date)
      if start_date.instance_of? String
        @start_date = Date.parse(start_date)
        @end_date = Date.parse(end_date)
      else
        @start_date = start_date
        @end_date = end_date
      end
      if @end_date - @start_date <= 0
        raise InvalidDateRange.new("End date must be after start date.")
      end
      @nights = Array.new((@end_date - @start_date).to_i)
      @nights[0] = @start_date
      index = 1
      
      while @nights.last == nil
        @nights[index] = @start_date + index
        index += 1
      end

    end
  
    def overlap?(other)
      return self.nights.include? other.start_date
    end

  end
end
