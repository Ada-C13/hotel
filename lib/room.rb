# I need to have a room class that will:

# Know:
# its room_number
# its cost
# its list of reservations (can be empty to begin)

# Be able to:
# access its list of reservations
# find reservation for given date range 
# tell whether it is available for a given date range

module Hotel
  class Room
    attr_reader :room_id, :cost
    attr_accessor :rez_list
    # is the Room Class able to change its own rez_list, or just the controller?
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



  end
end
