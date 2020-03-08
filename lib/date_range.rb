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

    # Reference: https://makandracards.com/makandra/984-test-if-two-date-ranges-overlap-in-ruby-or-rails

    # @start_date <= other.end_date && @end_date >= other.start_date   

    # When booking
    def overlap?(other)  #6/8 ~ 6/15    <=> 6/5 ~ 6/10
      # question
      # 6/5    <  6/15         &&   6/10    >     6/8 
      
      @start_date < other.end_date && @end_date > other.start_date  
    end

    def same?(other)
      (@start_date == other.start_date) && (@end_date == other.end_date)
    end 

    # attribute
    private
    def check_valid_date
      if @start_date >= @end_date || @start_date.class != Date || @end_date.class != Date
        raise ArgumentError, "An invalid date range"
      end 

      range = Date.today..Date.today + (30 * 12)

      if !(range.cover?(@start_date) && range.cover?(@end_date))
        raise ArgumentError, "Date range must be between #{range.first} and #{range.last}"  #i.e. 2020, 12, 31
      end 
    end 
  end 
end 