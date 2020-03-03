require 'date'
require 'date_range'

module Hotel
  class Reservation

    def initialize(
                  id:,
                  date_range:,
                  room_id:,
                  cost:
    )
      @id = id
      if id < 1
        raise ArgumentError
      end

      @date_range = date_range
      @room_id = room_id

      # not sure if I'll need this check here - in Room class instead?
      if room_id < 1 || room_id > 20
        raise ArgumentError
      end

      @cost = cost
      if cost <= 0 
        raise ArgumentError
      end
    end

  end
end