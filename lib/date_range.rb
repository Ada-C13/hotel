require 'date'

module Hotel
  class DateRange
    attr_reader :start_date, :end_date, :range

    def initialize(start_date:, end_date:)
      raise ArgumentError.new("start and end dates must be Date objects") if start_date.class != Date && end_date.class != Date
      @start_date = start_date
      @end_date = end_date
      @range = (@start_date .. @end_date).to_a
      raise ArgumentError.new("End date can not be before start date") if @end_date < @start_date
      
    end
    
    def overlap?(date_range)
      return (self.range & date_range.range).empty? ? "no overlap" : "overlap"
    end

  end
end
