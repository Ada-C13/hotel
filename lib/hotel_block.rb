# User Stories
  # As a user of the hotel system,
  # I can create a Hotel Block if I give a date range, collection of rooms, and a discounted room rate

module Hotel
  class HotelBlock
    attr_reader :date_range, :rooms, :discount_rate

    def initialize(date_range, rooms, discount_rate)
      @date_range = date_range
      @rooms = rooms
      check_availability()
      @discount_rate = discount_rate
    end

    def check_availability()
      @rooms.each do |room|
        room_available = room.check_availability(@date_range)
        raise ArgumentError.new("Not all rooms have availability") if !room_available
      end
      return true
    end
  end
end

  # I want an exception raised if I try to create a Hotel Block and at least one of the rooms is unavailable for the given date range
  # Given a specific date, and that a room is set aside in a hotel block for that specific date, I cannot reserve that specific room for that specific date, because it is unavailable
  # Given a specific date, and that a room is set aside in a hotel block for that specific date, I cannot create another hotel block that includes that specific room for that specific date, because it is unavailable
  # I can check whether a given block has any rooms available
  # I can reserve a specific room from a hotel block
  # I can only reserve that room from a hotel block for the full duration of the block
  # I can see a reservation made from a hotel block from the list of reservations for that date (see wave 1 requirements)
# Details
  # A block can contain a maximum of 5 rooms
  # When a room is reserved from a block of rooms, the reservation dates will always match the date range of the block
  # All of the availability checking logic from Wave 2 should now respect room blocks as well as individual reservations