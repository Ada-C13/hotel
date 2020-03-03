require 'date'

module Hotel
  class DateRange
    
    attr_reader :start_date, :end_date

    # your library code should assume that it's receiving Date objects to start
    def initialize(start_date, end_date)
      raise ArgumentError.new("Arguments passed in should be a Date class instance ") if !(start_date.is_a? Date) || !(end_date.is_a? Date)
      raise ArgumentError.new("End date should not be earlier than start date")  if end_date < start_date
      
      @start_date = start_date
      @end_date = end_date
    end

    def count_nights
      nights = (@end_date - @start_date).to_i
      return nights
    end


  end
end


# def initialize(start_year:, start_month:, start_day:, end_year:, end_month:, end_day:)
#   @start_date = Date.new(start_year, start_month, start_day)
#   @end_date = Date.new(end_year, end_month, end_day)

#   raise ArgumentError.new("End date should not be earlier than start date")  if @end_date < @start_date
# end