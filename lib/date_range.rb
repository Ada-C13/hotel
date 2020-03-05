require 'date'

module Hotel 
  class DateRange 

    attr_reader :start_date, :end_date 

    def initialize(start_date, end_date)
      @start_date = start_date
      @end_date = end_date

      # Invoke the method
      check_valid_date
    end 

    
    def nights 
      return @end_date.day - @start_date.day
    end 

    # TO DO
    # When searching
    # if the new date is between start and end date (excluding end_date)
    def include?(date)
      @start_date <= date && @end_date > date
    end 

    # https://makandracards.com/makandra/984-test-if-two-date-ranges-overlap-in-ruby-or-rails
    # TO DO
    # When booking
    def overlap?(other)    
      # TO DO: Check below
      # 6/8                 6/8          6/15           6/2 
      # @start_date <= other.end_date && @end_date >= other.start_date   #AS IS
      @start_date < other.end_date && @end_date > other.start_date  #TO BE
    end

    # attribute
    def check_valid_date
      if @start_date >= @end_date || @start_date.class != Date || @end_date.class != Date
        raise ArgumentError, "An invalid date range"
      end 

      range = Date.today..Date.new(Date.today.year, 12, 31)

      if !(range.cover?(@start_date) && range.cover?(@end_date))
        raise ArgumentError, "Date range must be between #{range.first} and #{range.last}"  #i.e. 2020, 12, 31
      end 
    end 
  end 
end 