module Hotel

  class HotelController
    # Generator
    # Access list of all rooms in hotel
    attr_reader :rooms, :reservations, :blocks
    
    # Constructor
    # Hotel has 20 rooms, 1 through 20
    def initialize
      @rooms = (1..20).to_a
      @reservations = []
      @blocks = [] 
    end

    # Reserve a room for a given date range
    # Determine which room to reserve given start and end dates 
    def reserve_room(start_date, end_date)
      room = available_rooms(start_date, end_date).first
      raise ArgumentError, "No Vacancy" if room == nil
      reservation = Hotel::Reservation.new(start_date, end_date, room)
      @reservations << reservation
      return reservation
    end

    # Access list of reservations for a specific date to track reservations by date
    def reservations_by_date(date)
      return @reservations.select do |reservation|
        reservation.range.include?(date)
      end
    end

    # Returns list of reservations for specific room and given date range
    def reservations_by_room(start_date, end_date, room)
      range = Hotel::DateRange.new(start_date, end_date)
      return @reservations.select do |reservation| # which reservations have an overlap with range passed
        reservation.range.overlap?(range) && reservation.room == room
      end
    end

    # Returns specific room available for date range
    def is_room_available?(start_date, end_date, room)
      return reservations_by_room(start_date, end_date, room).size == 0
    end

    # Returns list of rooms available for date range
    # Checks if the room is in a block. Respects room blocks as well as individual reservations
    def available_rooms(start_date, end_date)
      no_reservation = @rooms.select { |room| is_room_available?(start_date, end_date, room) }
      # Cannot reserve specific room, for specific date, if room already in a block for that specific date
      no_blocks = no_reservation.select { |room| is_room_unblocked?(start_date, end_date, room) }
      return no_blocks
    end

    # Wave 3

    # Create a block for given date range, set of rooms and rate
    def create_block(start_date, end_date, rooms, rate)
      raise ArgumentError, "Invalid room" unless rooms_valid?(rooms)
      # Exception raised if try to create a block and at least one of the rooms is unavailable for given date range
      raise ArgumentError, "Rooms not available" unless block_rooms_available?(start_date, end_date, rooms)
      block = Hotel::Block.new(start_date, end_date, rooms, rate)
      @blocks << block
      return block
    end

    # Create a reservation from a block
    # Reserve a specific room from a hotel block
    def reserve_from_block(block, room)
      raise ArgumentError, "Not a block" unless block.instance_of?(Hotel::Block)
      raise ArgumentError, "Room not in block" unless block.rooms.include?(room)
      # Only reserves a room from block for the full duration of the block
      # When a room is reserved from a block of rooms, the reservation dates will always match the date range of the block
      start_date = block.range.start_date
      end_date   = block.range.end_date
      raise ArgumentError, "No Vacancy" unless is_room_available?(start_date, end_date, room)
      reservation = Hotel::Reservation.new(start_date, end_date, room)
      # Reservation made from a hotel block adds to the list of reservations for that date
      @reservations << reservation
      return reservation
    end
    
    # Check if rooms are valid
    def rooms_valid?(rooms)
      return false unless rooms.instance_of?(Array)
      return false if rooms.size == 0
      rooms.each do |room|
        return false unless @rooms.include?(room)
      end
      return true
    end

    # Check if rooms for a block are available in date range
    # Cannot create another hotel block for specific date and room if room already in another block
    def block_rooms_available?(start_date, end_date, rooms)
      rooms.each do |room|
        return false unless is_room_available?(start_date, end_date, room)
        return false unless is_room_unblocked?(start_date, end_date, room)
      end
      return true
    end

    # Check if a room is not blocked in a specific date range
    def is_room_unblocked?(start_date, end_date, room)
      return blocks_by_room(start_date, end_date, room).size == 0
    end
    
    # Returns a list of blocks for that room in the date range
    def blocks_by_room(start_date, end_date, room)
      range = Hotel::DateRange.new(start_date, end_date)
      return @blocks.select do |block| # which blocks have an overlap with the range passed
        block.range.overlap?(range) && block.rooms.include?(room)
      end
    end
    
    # Checks whether a given block has any rooms available
    def available_rooms_in(block)
      return block.rooms.select { |room| is_room_available?(block.range.start_date, block.range.end_date, room)}
    end

  end # class HotelController

end # module Hotel *** add to others