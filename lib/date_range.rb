require 'date'

module Hotel 
  class DateRange 

    attr_reader :start_date, :end_date 

    def initialize(start_date, end_date)
      @start_date = Date.parse(start_date)
      @end_date = Date.parse(end_date)
      
      if @start_date > @end_date
        raise ArgumentError, "Start date must not be after end date"
      end 

      range = Date.today..Date.new(2020, 12, 31)

      if !(range.cover?(@start_date) && range.cover?(@end_date))
        raise ArgumentError, "Date range must be between #{Date.today} and #{Date.new(2020, 12, 31)}"
      end 
    end 


    def valid_dates?
      
      # range = Date.today..Date.new(2020, 12, 31)

      # if !(range.cover?(@start_date) && range.cover?(@end_date))
      #   raise ArgumentError, "Date range must be between #{Date.today} and #{Date.new(2020, 12, 31)}"
      # end 
    end

    def nights 
      return @end_date.day - @start_date.day
    end 
  end 
end 