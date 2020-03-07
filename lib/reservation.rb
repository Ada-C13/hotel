require "date"
require_relative "date_range"

module Hotel
  class Reservation
    attr_accessor :date_range, :room, :rate

    def initialize(date_range:, room:)
      @date_range = date_range
      @room = room
      @rate = 200
    end

    def calculate_cost
      cost = @date_range.nights * @rate
      return cost
    end
  end
end
