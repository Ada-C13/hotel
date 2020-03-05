module Hotel
  class DateRange
    attr_reader :start_date, :end_date, :date_range

    def initialize(start_date, end_date)
      @start_date = start_date
      @end_date = end_date
      @date_range = Array(@start_date .. @end_date)
    
      # User: I want an exception raised when an invalid date range is provided, so that I can't make a reservation for an invalid date range
      if @end_date < @start_date || @start_date == @end_date
        raise ArgumentError.new("Your check-out date must be after your check-in.")
      end
    
    end

    def overlap?(other)
      return false
    end

    def include?(date)
      return false
    end

    # calculate the number of nights for a reservation (end date is not a night)
    def nights
      @nights_booked = (@end_date - @start_date).to_i
      return @nights_booked
    end

  end
end
