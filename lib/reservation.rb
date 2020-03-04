require 'date'
require_relative 'date_range'
require_relative 'hotel_manager'

module Hotel
  class Reservation
    attr_reader :range, :start_date, :end_date, :id, :total_cost, :room_number, :nights

    def initialize(date_range)
      @start_date = date_range.start_date
      @end_date = date_range.end_date
      @range = (@start_date..@end_date).to_a
      @id = id
      @total_cost = total_cost
      @nights = date_range.total_nights
      @room_number = room_number
    end

  end
end