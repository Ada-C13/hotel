require "date"
require_relative "reservation"
require_relative "date_range"

module Hotel
  class Block
    def initialize(date_range:, rooms:, discounted_rate:)
      @date_range = date_range
      if rooms.length < 2 || rooms.length > 5
        raise ArgumentError, "Please provide between 2-5 rooms"
      end
      possible_rooms = (1..20).to_a
      # if !(possible_rooms.include?(rooms.each)) raise ArgumentError, "Please provide valid room numbers" end
      @rooms = rooms # array of room numbers
      @reservations = []
      # if discounted_rate.class != Integer && discounted_rate.class != Float raise ArgumentError, "Please enter valid number" end
      @discounted_rate = discounted_rate
    end
  end
end
