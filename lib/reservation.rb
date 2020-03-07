require "date"
require_relative "date_range"

module Hotel
  class Reservation
    attr_reader :id, :date_range, :room_num

    def initialize(date_range, room_num)
      @date_range = date_range
      @room_num = room_num
    end

    def total_price
      return (@date_range.nights) * 200
    end
  end
end
