require 'date'

require_relative 'date_range.rb'

module Hotel
  class Reservation
    attr_reader :start_date, :end_date, :room, :date_range
    
    def initialize(start_date, end_date)
      @start_date = start_date
      @end_date = end_date
    end

    def get_date_range(start_date,end_date)
      return Hotel::DateRange.new(start_date, end_date)
    end

  end
end