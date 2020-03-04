require 'date'

module Hotel
  class DateRange
    attr_accessor :start_date, :end_date

    def initialize(start_date, end_date)
      raise ArgumentError.new("start date has to be at least 1 day before end date") if (end_date - start_date).to_i < 1
      @start_date = start_date
      @end_date = end_date
    end

    def overlap?(range)
      self.nights.times do |day|
        range.nights.times do |day_in_range|
          return true if (range.start_date + day_in_range) == (@start_date + day)
        end
      end
      return false
    end

    def include?(date)
      self.nights.times do |day|
        return true if date == (@start_date + day)
      end
      return false
    end

    def nights
      date_diff = @end_date - start_date
      return date_diff.to_i
    end
  end
end