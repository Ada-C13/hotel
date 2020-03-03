require "date"
require_relative "reservation"

module Hotel
  class DateRange
    attr_reader :start_date, :end_date

    def initialize(start_date, end_date) # (string, string)
      unless start_date < end_date
        raise ArgumentError.new("End date can't be earlier than start date (got start date: #{start_date} ; end date: #{end_date})")
      end
      
      @start_date = Date.parse(start_date) 
      @end_date = Date.parse(end_date) 
    end

    def duration
      return @end_date - @start_date
    end

    # def overlap?(other)
    #   return false
    # end

    # def include?(date)
    #   return false
    # end

   

  end
end

