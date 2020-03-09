module Hotel
  class DateRange
    attr_reader :start_date, :end_date

    def initialize(start_date:, end_date:)
      #TODO: validate dates' input
      #TODO: add defaults (for example, one year from/before Date.today)
      @start_date = Date.parse(start_date)
      @end_date = Date.parse(end_date)      

      raise ArgumentError.new("End date cannot be equal to or come before start date.") if @end_date <= @start_date
    end

    def overlap?(date_range)
      raise ArgumentError.new("Must provide a date range.") unless date_range.is_a? DateRange 

      #TODO: efficient date checking (first compare years? months?)
      start_date < date_range.end_date && end_date > date_range.start_date
    end

    def nights
      (end_date - start_date).to_i
    end
  end
end