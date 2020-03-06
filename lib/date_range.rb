require 'date'

module Hotel
  class DateRange
    attr_accessor :start_date, :end_date

    def initialize(start_date, end_date)
      self.class.validate_date?(start_date,end_date)
      @start_date = start_date
      @end_date = end_date
    end

    def overlap?(input_range)

      a = self.start_date >= input_range.end_date
      b = self.end_date <= input_range.start_date

      if a || b
        return false
      else
        return true
      end

    end

    def include?(input_range)
  
    end

    def nights
      nights_number = (end_date - start_date).to_i
      return nights_number
    end

    private

    def self.validate_date?(start_date, end_date)

      date_format = '%Y-%m-%d'
      if !DateTime.strptime(start_date.to_s, date_format) || !DateTime.strptime(end_date.to_s, date_format)
        return rescue ArgumentError
      elsif start_date > end_date || start_date - end_date == 0
        raise ArgumentError.new("The end time is before the start time.")
      end
    end
  end 
end
# a = Hotel::DateRange.new("2015-10-10","2015-10-10")
# p a