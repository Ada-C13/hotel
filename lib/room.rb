# I need to have a room class that will:

# Know:
# its room_number
# its cost
# its list of reservations (can be empty to begin)

# Be able to:
# find/show its list of reservations
# tell whether it is available (interfaces with rez methods)
# find reservation for given date range

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


  end
end
