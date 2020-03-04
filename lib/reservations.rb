require 'date'

module Hotel
  class Reservation
    attr_reader :date_range, :room, :id

    def initialize(id:, date_range:, room: nil)
      @id = id
      @date_range = date_range
      @room = room
    end

  end
end
