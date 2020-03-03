require "date"
require_relative "date_range"

module Hotel
  class Reservation
    attr_reader :cost
    attr_accessor :date_range, :room

    def initialize(date_range:, cost: nil, room: nil)
      @date_range = date_range
      @cost = cost
      @room = room
    end

    # def calculate_cost(date_range) # implement "date" first
    # end
  end
end
