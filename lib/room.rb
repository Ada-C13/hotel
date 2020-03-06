# I need to have a room class that will:

# Know:
# its room_number
# its cost
# its list of reservations (can be empty to begin)

# Be able to:
# access its list of reservations 
# tell whether it is available for a given date range
# find reservation for given date range

# Rooms are responsible for creating own reservations and adding to rez list
require_relative 'date_range'
require_relative 'reservation'

module Hotel
  class Room
    attr_reader :room_id, :cost, :rez_list

    def initialize(room_id)
      @room_id = room_id
      @cost = 200
      @rez_list = []

      raise ArgumentError if room_id <= 0 || room_id > 20
    end

    # method to add reservation to room's rez_list
    def add_room_reservation(reservation_to_add)
      @rez_list << reservation_to_add
    end

    # method to check if there's a conflict with input range in any of its reservations
    def conflict?(input_range)
      @rez_list.each do |rez|
        if rez.date_range.overlap?(input_range) == true
          return true
        end
      end
      return false
    end

    # method to find reservation for given date range
    def find_by_range(input_range)
      overlapping = []
      @rez_list.each do |rez|
        if rez.date_range.overlap?(input_range) == true
          overlapping << rez
        end
      end
      return overlapping
    end

    # method to create a new reservation
    def create_room_reservation(input_range)
      if self.conflict?(input_range) == true
        return false
      else 
        # there are no conflicts, so create reservation
        new_reservation = Hotel::Reservation.new(input_range, self.room_id)
        add_room_reservation(new_reservation)
        return true
      end
    end

  end
end
