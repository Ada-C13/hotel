require 'date'
require_relative 'room'

module Hotel
  class Reservation
    attr_reader :room, :date_range, :cost

    def initialize(room:, start_date:, end_date:)
      @room = room
      @date_range = DateRange.new(start_date: start_date, end_date: end_date)
      @cost = @date_range.days * 200
    end
  end
end