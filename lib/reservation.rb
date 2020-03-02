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
      @checkin = checkin
      @checkout = checkout
      @room_id = room_id
    end

  end
end