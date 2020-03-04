module Hotel
  class DateRange
    attr_accessor :start_date, :end_date

    def initialize(start_date, end_date)
      @start_date = start_date
      @end_date = end_date

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
      num_nights = @end_date - @start_date
      return num_nights
    end
  end
end
