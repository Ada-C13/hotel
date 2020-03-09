require 'date'

module Hotel
  class DateRange
    attr_accessor :start_date, :end_date

    def initialize(start_date, end_date)
      self.class.validate_date?(start_date,end_date)
      @start_date = start_date
      @end_date = end_date
    end

    # An input range given will not be part of any other date_range
    # It returns true if there is an overlap or false if there is not.
    # input_range = Hotel::DataRange instance.
    def overlap?(input_range)
      a = self.start_date >= input_range.end_date
      b = self.end_date <= input_range.start_date
      return a || b ? false : true 
    end

    def nights
      nights_number = (end_date - start_date).to_i
      return nights_number
    end

    private
    # validate_date? validates that start and end date have valid format.
    # start date cannot be after the end date 
    # Exception raised when an invalid date range is provided
    def self.validate_date?(start_date, end_date)

      date_format = '%Y-%m-%d'
      if !DateTime.strptime(start_date.to_s, date_format) || !DateTime.strptime(end_date.to_s, date_format)
        raise ArgumentError
      end

      if start_date > end_date
        raise ArgumentError.new("The end time is before the start time.")
      end

      if start_date - end_date == 0
        raise ArgumentError.new("Start date and end date are the same.")
      end
    end
  end 
end
