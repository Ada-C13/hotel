require 'pry'
require_relative 'room'

module Hotel
  class Reservation
    attr_reader :rooms, :date_range, :cost

    def initialize(rooms:, date_range:)
      @rooms = rooms
      @date_range = date_range
      @cost = @date_range.days * 200
    end
  end
end