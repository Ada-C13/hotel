require 'date'
require_relative 'date_range'
require_relative 'hotel_manager'

module Hotel
  class Reservation
    attr_reader :date_range, :id, :total_cost, :room_number, :nights

    def initialize(date_range)
      @date_range = date_range
      @id = id
      @total_cost = total_cost
      @nights = date_range.total_nights
      @room_number = room_number
    end

  end
end