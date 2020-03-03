require 'date'

module Hotel
  class DateRange
    attr_accessor :start_date, :end_date

    def initialize(start_date, end_date)
      self.class.validate_date(start_date)
      self.class.validate_date(end_date)
    end

    def overlap?(data_range)
      return false
    end

    def include?(date)
      return false
    end

    def nights
      return 3
    end


    private
    
    def self.validate_date(date)
      return true
    end

  end
end