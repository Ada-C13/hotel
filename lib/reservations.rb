
module Hotel
  class Reservation
    attr_reader :date_range, :room
    attr_accessor :block_reservation

    def initialize(date_range:, room: nil)
      @date_range = date_range
      @room = room
      @block_reservation = true || false
    end

  end
end
