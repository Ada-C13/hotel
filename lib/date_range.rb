require 'date'

module HotelBooking
  class DateRange
    attr_accessor :start_date, :end_date

    def initialize(start_date:, end_date:)
      @start_date = start_date
      @end_date = end_date

      raise ArgumentError.new("End date needs to be after start date") if end_date <= start_date

      raise ArgumentError.new("Start date cannot be in the past") if start_date < Date.today
        
    end

    # def overlap?(other)
    #   return false
    # end

    # def include?(date)
    #   return false
    # end

    # def nights
    #   return 3
    # end
  end
end