module Hotel
  class HotelController
    attr_reader :rooms
    attr_accessor :reservations, :hotel_blocks
    def initialize
      @rooms = Array.new(20){|i| Hotel::Room.new(i+1)}
      @reservations = []
      @hotel_blocks = [] #contain a number of rooms and a specific set of days
    end
  
    ################# Wave 1

    # Access the list of all of the rooms in the hotel
    def self.rooms
        room_list = HotelController.rooms 
      return room_list
    end

    # Access the list of reservations for a specified room and a given date range
    def reservations_list_room_and_date(given_room, given_date_range)
      reservations_list_of_given_room_date_range = reservations.select do |res|
        res.date_range.overlap?(given_date_range) && res.room == given_room 
      end
      return reservations_list_of_given_room_date_range
    end

    # Add reservation to the list of the reservations
    def add_reservation(reservation)
      @reservations << reservation
    end 
    
    # Access the list of reservations for a specific date, so that I can track reservations by date
    def reservations_list(date)
      reservation_list = reservations.select do |res|
        res.date_range.include?(date)
        end 
        return reservation_list
    end

     # Can get the total cost for a given reservation
    def total_cost(reservation)
      total_cost = reservation.cost
      return total_cost
    end

    ##################### Wave 2
    # Get reservations_list for a given date range
    def reservations_list_by_date_range(start_date, end_date)
      given_date_range = Hotel::DateRange.new(start_date, end_date)
      # Get the reservations_list for the given date range
      reservations_list_by_date_range = reservations.select do |res|
      res.date_range.overlap?(given_date_range)
      end
    end

    def reserved_rooms_list(start_date, end_date) 
      given_date_range = Hotel::DateRange.new(start_date, end_date)
      # Get reservations_list for a given date range
      reservations_list_by_date_range = reservations_list_by_date_range(start_date, end_date)

      # Get all the room that have been reserved for the given date range 
      all_reserved_rooms = reservations_list_by_date_range.map do |res|
        res.room
      end
      return all_reserved_rooms 
    end 

    # I can view a list of rooms that are not reserved for a given date range, 
    # so that I can see all available rooms for that day
    def available_rooms(start_date, end_date)
      given_date_range = Hotel::DateRange.new(start_date, end_date)

      # get all the room that have been reserved for the given date range 
      all_reserved_rooms = reserved_rooms_list(start_date, end_date)
      # get all rooms that are in the hotel blocks
      all_rooms_hotel_block = rooms_list_for_hotel_block(start_date, end_date) 

      # get the aviable_rooms_list
      available_rooms_list = rooms.reject do |room|
        all_reserved_rooms.any? {|res_room| res_room.id == room.id} || all_rooms_hotel_block.any? {|block_room| block_room.id == room.id}  
      end
      return available_rooms_list
    end

    # I can make a reservation of a room for a given date range, 
    # and that room will not be part of any other reservation overlapping that date range
    # done already in wave 1
  
    def reserve_room(start_date, end_date)
      given_date_range = Hotel::DateRange.new(start_date, end_date)
      avialable_rooms_list = available_rooms(start_date, end_date)
      if avialable_rooms_list.empty?
        raise NoRoomAvailableError.new("there is no available room.")
      end
      id = reservations.length + 1      
      reservation = Hotel::Reservation.new(id,given_date_range, avialable_rooms_list.first)
      add_reservation(reservation)
      return reservation
    end  

    ############## Wave 3

    # Add hotel_block method
    def add_hotel_block(hotel_block)
      @hotel_blocks << hotel_block
    end
    # Get the hotel_block_list for a given date (not exact match date range)
    def hotel_block_list(start_date, end_date)
      given_date_range = Hotel::DateRange.new(start_date, end_date)
      # get the list of the hotel_block for the given date
      hotel_block_list = hotel_blocks.select do |hotel_block|
        hotel_block.date_range.overlap?(given_date_range)
      end
      return hotel_block_list
    end

    # Get the rooms_list_for_hotel_block
    def rooms_list_for_hotel_block(start_date, end_date) 
      hotel_block_list = hotel_block_list(start_date, end_date)
      # get all arrays of rooms from the hotel_block_list for the given date 
      rooms_hotel_block_arrays = hotel_block_list.map do |hotel_block|
        hotel_block.rooms
      end
      # get all the rooms from the list of 
      all_rooms_hotel_block =  rooms_hotel_block_arrays.flatten
      return all_rooms_hotel_block
    end 
    
    # Create a hotel_block
    def create_hotel_block(date_range, rooms_array, discount_rate)
      # all rooms of rooms_array must be available (not in the reservations list) during the given date range
      all_reserved_rooms = reserved_rooms_list(date_range.start_date, date_range.end_date)
  
      # Cannot create another hotel block that any existing block includes that specific room for that specific date
      all_rooms_hotel_block = rooms_list_for_hotel_block(date_range.start_date, date_range.end_date) 
      # an exception raised if I try to create a Hotel Block 
      # and at least one of the rooms is unavailable for the given date range

      rooms_array.each do |room|
        if all_reserved_rooms.any? {|r|r == room} || all_rooms_hotel_block.any? {|r| r == room}
          raise ArgumentError.new("There is reservation conflict")
        end
      end
      hotel_block = Hotel::HotelBlock.new(date_range, rooms_array, discount_rate)
      add_hotel_block(hotel_block)
      return hotel_block
    end

    # check whether a given block has any rooms available
    def available_rooms_of_block(hotel_block) 
      if hotel_block.rooms.empty?
        raise ArgumentError.new("The hotel block cannot be made without having a room")
      else
        return hotel_block.rooms
      end
    end
    
  # Get the list of the hotel_block for a specific full date range (exact match the full date range)
    def hotel_blocks_for_specific_date_range(start_date, end_date)
      specific_date_range = Hotel::DateRange.new(start_date, end_date)
      hotel_blocks_for_specific_date_range = hotel_blocks.select do |hotel_block|
        hotel_block.date_range == specific_date_range
      end
      return hotel_blocks_for_specific_date_range
    end

  # Get available_rooms_of_hotel_blocks for a specific full date range (exact match the full date range)
    def available_rooms_of_hotel_blocks(start_date, end_date)
      hotel_blocks_for_specific_date_range = hotel_blocks_for_specific_date_range(start_date, end_date)
      if hotel_blocks_for_specific_date_range.empty? 
        raise ArgumentError.new ("no hotel_block for the given date range.")
      end
      available_rooms_of_hotel_blocks = hotel_blocks_for_specific_date_range.map do |hotel_block|
        hotel_block.rooms
      end
      all_available_rooms_of_hotel_blocks = available_rooms_of_hotel_blocks.flatten
    end

  # Get specific hotel_block with a given room, start_date, and end_date
  def specific_hotel_block(room, start_date, end_date)
    specific_date_range = Hotel::DateRange.new(start_date, end_date)
    # Check to see which hotel_block the room lives in (one room can be assigned to only one hotel_block for a specific date range )
    specific_hotel_block_list = hotel_blocks.select do |hotel_block|
      hotel_block.date_range == specific_date_range && hotel_block.rooms.any? {|r| r.id == room.id}
    end
    if specific_hotel_block_list.empty?
      raise ArgumentError.new("there is no hotel_block for the given room or date range.")
    end
    specific_hotel_block = specific_hotel_block_list[0]
    return specific_hotel_block
  end

  # remove the room from the hotel_block for a specific date_range
  def remove_room_from_hotel_block(room, start_date, end_date)
    specific_hotel_block = specific_hotel_block(room, start_date, end_date)
    specific_hotel_block.rooms.delete(room)
    return specific_hotel_block
  end

  # remove/delete the whole hotel block 
  def delete_hotel_block(hotel_block)
    hotel_blocks.delete(hotel_block)
  end
  
  # I can reserve a specific room from a hotel block
  # I can only reserve that room from a hotel block for the full duration of the block
  # I can see a reservation made from a hotel block from the list of reservations for that date (see wave 1 requirements)
  def reserve_room_from_hotel_block(room,start_date, end_date)
    given_date_range = Hotel::DateRange.new(start_date, end_date)
    all_available_rooms_of_hotel_blocks = available_rooms_of_hotel_blocks(start_date, end_date)
      if all_available_rooms_of_hotel_blocks.empty?
        raise NoRoomAvailableError.new("there is no available room.")
      end 
      if all_available_rooms_of_hotel_blocks.any?(room)
        id = reservations.length + 1      
        reservation = Hotel::Reservation.new(id,given_date_range,room)
        # Add the reservation to the reservation list 
        add_reservation(reservation)
        # remove the room from the all_available_rooms_of_hotel_blocks
        hotel_block_after_reservation = remove_room_from_hotel_block(room, start_date, end_date)
        if hotel_block_after_reservation.rooms.empty?
          delete_hotel_block(hotel_block_after_reservation)
        end
      end
      return reservation
    end
  end
end