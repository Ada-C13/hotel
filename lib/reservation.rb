require "date"
require_relative "date_range"

module Hotel
  class Reservation
    attr_accessor :date_range, :room

    def initialize(date_range:, room:)
      @date_range = date_range
      @room = room
    end

    def calculate_cost
      cost = @date_range.nights * 200
      return cost
    end
  end
end
