module Hotel
  class DateRange
    attr_accessor :start_date, :end_date

    def initialize(start_date, end_date)
      if !(start_date.is_a? Date) || !(end_date.is_a? Date)
        raise ArgumentError.new("If the start_date and end_date is not a Date")
      end

      if end_date < start_date
        raise ArgumentError.new("If the start_date is biger then the end_date")
      end

      # if start_date < Date.today
      #   raise ArgumentError.new("If the start_date is date in paste") 
      # end

      if start_date == end_date
        raise ArgumentError.new("If the start_date date is same with end_date") 
      end
     
      @start_date = start_date
      @end_date = end_date
    end

    def ==(other)
      start_date == other.start_date && end_date == other.end_date
    end

    def overlap?(other)
      start_date < other.end_date && other.start_date < end_date
    end

    def include?(date)
      start_date <= date && date < end_date
      
    end

    def calculate_nights
      nights = (end_date - start_date).to_i
      return nights
    end 

  end
end