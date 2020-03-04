require 'date'

module Hotel
  class DateRange

    # start_date and #end_date are required to be date objects
    def initialize(start_date, end_date)
      @start_date = start_date
      @end_date = end_date

      raise ArgumentError if start_date > end_date
      # raise ArgumentError if start_date.class != Date || end_date.class != Date
    end

    def overlap?(comparison_range)
      # if comparison_range.start_date 
      #   # is at least one of the dates inside start or end?

      #   || comparison_range.end_date 
    end

  end
end
