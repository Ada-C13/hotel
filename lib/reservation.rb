module Hotel
  class Reservation
    attr_reader :date_range, :room

    def initialize(date_range, room)
      @date_range = date_range
      @room = room
    end

    # def cost
    # end
  end
end
