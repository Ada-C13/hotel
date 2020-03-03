require 'date'
require_relative 'room'

module Hotel
  class Reservation
    attr_reader :room, :start_date, :end_date, :cost

    def initialize(room:, start_date:, end_date:)
      raise ArgumentError, "Check-out can't be earlier or the same day as check-in date" if end_date <= start_date
      @room = room
      @start_date = Date.parse(start_date)
      @end_date = Date.parse(end_date)
      @cost = (@end_date - @start_date) * 200
    end
  end
end