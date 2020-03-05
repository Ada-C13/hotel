# I need to have a room class that will:

# Know:
# its room_number
# its cost
# its list of reservations (can be empty to begin)

# Be able to:
# access its list of reservations
# find reservation for given date range 
# tell whether it is available for a given date range

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

    # method to create a new reservation
    # def create_room_reservation(input_range)
      # call helper method below with one line invocation:
      # check to make sure input range doesn't conflict with existing room reservations
      # if so, return false
      # else, create rez and add to rez list
      # then return true
      # created_rez = Hotel::Reservation.new(input_range, self.room_id)
      # @rez_list << created_rez
    # end

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



  end
end
