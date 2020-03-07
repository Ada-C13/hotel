module Hotel
  class HotelController
    # Access the list of all of the rooms in the hotel
    attr_reader :rooms, :reservations, :blocks
    
    # Constructor
    # Hotel has 20 rooms, numbered 1 through 20
    def initialize
      @rooms = (1..20).to_a
      @reservations = []
      @blocks = [] 
    end

    # Reserve a Room for a Given Date Range
    # Given only start and end dates, determine which room to use for the reservation
    def reserve_room(start_date, end_date)
      room = available_rooms(start_date, end_date).first
      raise ArgumentError, "No Vacancy" if room == nil
      reservation = Hotel::Reservation.new(start_date, end_date, room)
      @reservations << reservation
      return reservation
    end

    # Access the list of reservations for a specific date, so that I can track reservations by date
    def reservations_by_date(date)
      return @reservations.select do |reservation|
        reservation.range.include?(date)
      end
    end

    # Returns Reservation(s) Specific for Room and Range
    # Access the list of reservations for a specified room and a given date range
    def reservations_by_room(start_date, end_date, room)
      range = Hotel::DateRange.new(start_date, end_date)
      return @reservations.select do |reservation| # which reservations have an overlap with the ranged passed
        reservation.range.overlap?(range) && reservation.room == room
      end
    end

    # Returns Specific Room Available for a Date Range
    def is_room_available?(start_date, end_date, room)
      return reservations_by_room(start_date, end_date, room).size == 0
    end

    # Returns List of Rooms Available for a Date Range
    # Checks also if the room is in a block
    def available_rooms(start_date, end_date)
      no_reservation = @rooms.select { |room| is_room_available?(start_date, end_date, room) }
      # Availability checking logic respects room blocks as well as individual reservations
      # Given a specific date, and that a room is set aside in a hotel block for that specific date, I cannot reserve that specific room for that specific date, because it is unavailable
      no_blocks      = no_reservation.select { |room| is_room_unblocked?(start_date, end_date, room) }
      return no_blocks
    end

    ##### Wave 3

    # Create a Block for a Given Date Range, a Set of Rooms and a Rate
    def create_block(start_date, end_date, rooms, rate)
      raise ArgumentError, "Invalid room" unless rooms_valid?(rooms)
      # Exception raised if I try to create a Hotel Block and at least one of the rooms is unavailable for the given date range
      raise ArgumentError, "Rooms not available" unless block_rooms_available?(start_date, end_date, rooms)
      block = Hotel::Block.new(start_date, end_date, rooms, rate)
      @blocks << block
      return block
    end

    # Create a Reservation from a Block
    # Reserve a specific room from a hotel block
    def reserve_from_block(block, room)
      raise ArgumentError, "Not a block" unless block.instance_of?(Hotel::Block)
      raise ArgumentError, "Room not in block" unless block.rooms.include?(room)
      # Only reserves room from a hotel block for the full duration of the block
      # When a room is reserved from a block of rooms, the reservation dates will always match the date range of the block
      start_date = block.range.start_date
      end_date   = block.range.end_date
      raise ArgumentError, "No Vacancy" unless is_room_available?(start_date, end_date, room)
      reservation = Hotel::Reservation.new(start_date, end_date, room)
      # Reservation made from a hotel block adds to the list of reservations for that date
      @reservations << reservation
      return reservation
    end
    
    # Check if Rooms are Valid
    def rooms_valid?(rooms)
      return false unless rooms.instance_of?(Array)
      return false if rooms.size == 0
      rooms.each do |room|
        return false unless @rooms.include?(room)
      end
      return true
    end

    # Check if the Rooms for a Block are Available in the Date Range
    # Given a specific date, and that a room is set aside in a hotel block for that specific date, I cannot create another hotel block that includes that specific room for that specific date, because it is unavailable
    def block_rooms_available?(start_date, end_date, rooms)
      rooms.each do |room|
        return false unless is_room_available?(start_date, end_date, room)
        return false unless is_room_unblocked?(start_date, end_date, room)
      end
      return true
    end

    # Check if a Room is Not blocked in a Specific Date Range
    def is_room_unblocked?(start_date, end_date, room)
      return blocks_by_room(start_date, end_date, room).size == 0
    end
    
    # Returns a list of blocks for that Room in the Date Range
    def blocks_by_room(start_date, end_date, room)
      range = Hotel::DateRange.new(start_date, end_date)
      return @blocks.select do |block| # which blocks have an overlap with the ranged passed
        block.range.overlap?(range) && block.rooms.include?(room)
      end
    end
    
    # Checks whether a given block has any rooms available
    def available_rooms_in(block)
      return block.rooms.select { |room| is_room_available?(block.range.start_date, block.range.end_date, room)}
    end

  end # class HotelController
end # module Hotel *** add to others