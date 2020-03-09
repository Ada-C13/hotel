require_relative 'reservation'

module Hotel
  class Room
    attr_reader :room_id, :rez_list

    def initialize(room_id)
      @room_id = room_id
      @rez_list = []

      raise ArgumentError if room_id <= 0 || room_id > 20
    end

    def add_room_reservation(reservation_to_add)
      @rez_list << reservation_to_add
    end

    def conflict?(input_range)
      @rez_list.each do |rez|
        if rez.date_range.overlap?(input_range)
          return true
        end
      end

      return false
    end

    def find_by_range(input_range)
      overlapping = []
      @rez_list.each do |rez|
        if rez.date_range.overlap?(input_range)
          overlapping << rez
        end
      end
      return overlapping
    end

    def create_room_reservation(input_range)
      if self.conflict?(input_range) == true
        return false
      else 
        new_reservation = Hotel::Reservation.new(input_range, self.room_id)
        add_room_reservation(new_reservation)
        return true
      end
    end

  end
end