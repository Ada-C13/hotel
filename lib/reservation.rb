require 'date'
require_relative 'date_range'
require_relative 'hotel_manager'

module Hotel
  class Reservation
    attr_reader :date_range, :id, :room_number, :nights

    attr_accessor :total_cost

    def initialize(date_range, id = "", room_number = "")
      @date_range = date_range
      @id = id
      @total_cost = total_cost
      @nights = date_range.total_nights
      @room_number = room_number
    end

  end
end