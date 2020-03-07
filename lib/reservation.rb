require_relative 'date_range'

module Hotel
  class Reservation

    attr_reader :date_range, :room_id

    def initialize(date_range,room_id)

      @date_range = date_range
      @room_id = room_id

      # not sure if I'll need this check here - in Room class instead?
      if room_id < 1 || room_id > 20
        raise ArgumentError
      end

    end

    def cost
      num_nights = (@date_range.end_date - @date_range.start_date).to_i
      fixed = 200
      total_cost = num_nights * fixed
      return total_cost
    end

  end
end