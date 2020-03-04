module Hotel
  class DateRange
    attr_accessor :start_date, :end_date

    def initialize(start_date, end_date)
      @start_date = start_date
    end

    def overlap?(other)
      return false
    end

    def include?(date)
      return false
    end

    # calculate the number of nights for a reservation (end date is not a night)
    def nights
      return 3
    end
  end
end