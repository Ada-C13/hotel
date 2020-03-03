module Hotel
  class DateRange
    attr_accessor :start_date, :end_date

    def initialize(start_date, end_date)
      raise ArgumentError.new("If the start date is biger then the end date") if end_date < start_date
      raise ArgumentError.new("If the start date is date that we pas") if start_date < Date.today
      raise ArgumentError.new("If the start date is same with end daye") if start_date == end_date
      raise ArgumentError.new("If the start date and end_date is not a Date") if !(start_date.is_a? Date) || !(end_date.is_a? Date)
      
      @start_date = start_date
      @end_date = end_date
    end

    def overlap?(other)
      return false
    end

    def include?(date)
      return false
    end

    def calculate_nights
      nights = (end_date - start_date).to_i
      return nights
    end
  end
end