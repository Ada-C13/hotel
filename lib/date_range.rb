require 'date'
module Hotel
  class InvalidDateError < StandardError

  end
  class DateRange
    attr_reader :start_date, :end_date, :nights

    def initialize(start_date, end_date)
      if !(start_date.instance_of?(Date) || end_date.instance_of?(Date))
        raise InvalidDateError.new("End and start dates must be instances of Date.")
      else
        @start_date = start_date
        @end_date = end_date
      end
      if @end_date - @start_date <= 0
        raise InvalidDateError.new("End date must be after start date.")
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
      # TO DO: get help comparing the complexity
      #  of these two different solutions

      # if self.nights.include?(other.start_date) || 
      #   self.nights.include?(other.nights.last)
      #   return true
      # elsif other.nights.include?(self.start_date) ||
      #   other.nights.include?(self.nights.last)
      #   return true
      # else
      #   return false
      # end
      other.nights.each do |night|
        # this uses #include? not ruby enumerable
        if self.include? night
          return true
        end
      end
      return false
    end

    # TO DO: is this redundant, or is this good encapsulation?
    def include?(date)
      return nights.include? date
    end

    def num_nights
      return nights.length
    end

  end
end
