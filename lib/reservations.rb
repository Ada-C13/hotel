require 'date'

module Hotel
  class Reservation
    attr_reader :date_range, :room

    def initialize(date_range:, room: nil)
      @date_range = date_range
      @room = room
    end

  end
end
