require 'date'

module Hotel
  class Reservation

    def initialize(
                  id:,
                  checkin:,
                  checkout:,
                  room_id:
    )
      @id = id
      if id < 1 || id > 20
        raise ArgumentError
      end

      @checkin = checkin
      @checkout = checkout

      if checkin > checkout
        raise ArgumentError
      end

      @room_id = room_id
      if room_id < 1 || room_id > 20
        raise ArgumentError
      end
    end

  end
end