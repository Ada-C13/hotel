module Hotel
  class DateRange
    attr_accessor :start_date, :end_date

    def initialize(start_date, end_date)
      unless start_date.instance_of?(Date) || end_date.instance_of?(Date)
        raise ArgumentError.new("start_date and end_date have to be a date type")
      end
      
      if end_date < start_date
        raise ArgumentError.new("The end_date cannot be less than start_end") 
      end

      if start_date == end_date
        raise ArgumentError.new("The start_date cannot be the same as end_date") 
      end
      @start_date = start_date
      @end_date = end_date
    end

    def overlap?(other) #other is another instance of date_range
      start_date < other.end_date && other.start_date < end_date
    end

    def include?(date) # date is a date
      start_date <= date && end_date > date 
    end

    # def include?(date_range) # other is an instance of date_range
    #   start_date <= date_range.start_date && end_date > date_range.end_date 
    # end

    def count_nights
      total_nights = (end_date - start_date).to_i
      return total_nights
    end
  end
end
