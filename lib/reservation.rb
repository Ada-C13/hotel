module Hotel
  class Reservation
    attr_reader :date_range, :room

    def initialize(date_range, room)
      @date_range = date_range
      @room = room
    end

    def calculate_total_cost
      return (@date_range.nights) * 200
    end

  end
end
