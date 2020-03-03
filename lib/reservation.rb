require 'date'
require_relative 'date_range'
require_relative 'hotel_manager'

module Hotel
  class Reservation < DateRange
    attr_reader :range, :start_date, :end_date, :id, :total_cost, :room_number, :nights

    def initialize(daterange)
      @start_date = daterange.start_date
      @end_date = daterange.end_date 
      @range = (@start_date..@end_date).to_a    
      @id = id
      @total_cost = total_cost
      @nights = daterange.total_nights
      @room_number = room_number
    end

  end
end