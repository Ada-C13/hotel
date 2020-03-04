module Hotel
  class DateRange
    attr_accessor :start_date, :end_date

    def initialize(start_date, end_date)

      # allowing for string inputs for dates
      if start_date.is_a?(String) && end_date.is_a?(String)
        start_date = Date.parse(start_date)
        end_date = Date.parse(end_date)
      else
        start_date = start_date
        end_date = end_date
      end

      # verifying proper date range
      difference = end_date - start_date
      if difference == 0
        raise ArgumentError, "Cannot have 0 length date range"
      elsif difference < 0
        raise ArgumentError, "Cannot have negative length for a date range"
      else
        @start_date = start_date
        @end_date = end_date
      end

      @start_date = start_date
      @end_date = end_date
    end

    # # maybe put this code above into verification method?
    #  # allowing for string inputs for dates
    #  if start_date.is_a?(String) && end_date.is_a?(String)
    #   start_date = Date.parse(start_date)
    #   end_date = Date.parse(end_date)
    # else
    #   start_date = start_date
    #   end_date = end_date
    # end

    # verifying proper date range
    # difference = end_date - start_date
    # if difference == 0
    #   raise ArgumentError, "Cannot have 0 length date range"
    # elsif difference < 0
    #   raise ArgumentError, "Cannot have negative length for a date range"
    # else
    #   @start_date = start_date
    #   @end_date = end_date
    # end
    # def verification()
    # end

    def overlap?(range)

      return false
    end

    def include?(date)
      return false
    end

    def nights
      nights = (end_date - start_date) - 1
    end
  end
end