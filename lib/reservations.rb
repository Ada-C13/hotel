require 'time'

module Hotel
  class Reservations 
    def initialize(id:, date_in:, date_out:, room_id:)
        @id = id
        @date_in = date_in
        @date_out = date_out
        @room_id = room_id
    end
  end
end