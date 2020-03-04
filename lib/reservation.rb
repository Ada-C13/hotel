require_relative 'date_range'

module Hotel
  class Reservation

    attr_reader :id, :date_range, :room_id
    def initialize(id,date_range,room_id)
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

    end

  end
end