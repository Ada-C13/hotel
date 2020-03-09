module Hotel
  class HotelBlock
    attr_reader :date_range, :rooms, :discount_rate, :id

    def initialize(date_range, rooms, discount_rate, id)
      @date_range = date_range
      @rooms = rooms
      @discount_rate = discount_rate
      calculate_discounted_rate()
      @id = id
    end

    def calculate_discounted_rate()
      if @discount_rate > 1
        @discount_rate *= 0.01
      end
      @rooms.each do |room|
        room.cost -= (room.cost * @discount_rate)
      end
    end

  end
end

  # I can check whether a given block has any rooms available
  # I can reserve a specific room from a hotel block
  # I can only reserve that room from a hotel block for the full duration of the block
  # I can see a reservation made from a hotel block from the list of reservations for that date (see wave 1 requirements)
# Details
  # A block can contain a maximum of 5 rooms
  # When a room is reserved from a block of rooms, the reservation dates will always match the date range of the block
  # All of the availability checking logic from Wave 2 should now respect room blocks as well as individual reservations