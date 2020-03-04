require_relative 'date_range'

module Hotel
  class Reservation
    attr_reader :id, :room, :date_range
    def initialize(check_in_time, check_out_time, room)
      @id = rand(111111..999999)
      @date_range = Hotel::DateRange.new(check_in_time, check_out_time)
      @room = room
      @cost = 0
    end

    def cost
      return room.cost * date_range.nights
    end
  end
end