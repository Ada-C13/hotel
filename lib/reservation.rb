require_relative 'date_range'

module Hotel
  class Reservation
    attr_reader :id, :room_id, :date_range
    def initialize(check_in_time, check_out_time, room_id)
      @id = rand(111111..999999)
      @date_range = Hotel::DateRange.new(check_in_time, check_out_time)
      @room_id = room_id
      @cost = @date_range.nights * 200
    end
  end
end