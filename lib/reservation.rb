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

  end
end