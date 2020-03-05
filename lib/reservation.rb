require 'date'
require_relative 'room'

module Hotel
  class Reservation
    attr_reader :room, :date_range, :cost

    def initialize(room:, date_range:)
      @room = room
      @date_range = date_range
      @cost = @date_range.days * 200
    end
  end
end