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
      # if the array of the combined arrays is empty, there is no overlap, so return false
      # if the array is not empty, return true
      return overlap = (self.range & date_range.range).empty? ? false : true
    end

    def nights
      return @range.count - 1
    end


  end
end
