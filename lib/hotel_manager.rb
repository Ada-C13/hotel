module Hotel 
  class HotelManager 

    ROOM_NUMBERS = 20 

    attr_reader :rooms, :reservations, :blocks 

    def initialize
      @rooms = []
      @reservations = {
        :individual => [],
        :block => []
      }
      @blocks = []

      ROOM_NUMBERS.times do |i| 
        @rooms << Hotel::Room.new(id: i + 1)
      end 
    end 


    # (1) list of reservations with a given date range & room id 
    #  overlap => (booking)
    def reservations_per_room(date_range, room)
      # If the room number is the same
      # check the reservation inside of the room 
      return @reservations[:individual].filter do |reservation|
        (reservation.room.id == room.id) && (reservation.date_range.overlap?(date_range))
      end 
    end 
    
    
    # (2) Find available room numbers (with given date range) 
    #  and use the "reservations_per_room" from (1)
    def available_room_ids(date_range) 
 
      # Find available rooms that are not reserved for the given date range
      available_rooms = @rooms.select do |room| 

        # Find reservation list per room
        reservations = reservations_per_room(date_range, room)
        
        reservations.empty? 
      end 

      return available_rooms.map { |room| room.id }
    end 


    def make_reservation(date_range)
      # Find available rooms for the specific date range
      available_room_ids = available_room_ids(date_range)
      
      if available_room_ids.empty? 
        raise ArgumentError, "There are no available rooms"
      end 

      # Create an instance of Reservation
      room = find_room_by_id(available_room_ids[0])
      reservation = Reservation.new(date_range, room: room)
      
      self.add_reservation(reservation, type: :individual)

      return reservation
    end 


    # (4) Find reservations for date 
    # => include (searching)
    def find_reservations(date)
      return @reservations[:individual].find_all do |reservation|
          (reservation.date_range.include?(date)) && (reservation.room) 
      end 
    end 


    # ====== block =====

    def block_reservations_per_room(date_range, room)

      list = []
  
      reservations_with_same_range = @reservations[:block].select do |reservation|  
        reservation.block.date_range.overlap?(date_range)
      end 

      reservations_with_same_range.each do |reservation| 
        reservation.block.rooms.each do |block_room|
          if block_room.id == room.id
            list << reservation  
          end 
        end 
      end 
      return list
    end 


    def set_block(date_range, number_of_rooms: 1)
      # Change test file
      if (number_of_rooms < 1) || (number_of_rooms > 5)
        raise ArgumentError, "A block can contain between 1 and 5 rooms (maximum of 5 rooms)"
      end 

      # Find available rooms for the specific date range
      available_room_ids = available_room_ids(date_range) 
      
      if (available_room_ids.length < number_of_rooms) 
        raise ArgumentError, "We have only #{available_room_ids.length} rooms between #{date_range.start_date} and #{date_range.end_date} you chose"
      end 

      rooms = []

      number_of_rooms.times do |i|
        id = available_room_ids[-1]

        room = find_room_by_id(id)
        rooms << room

        available_room_ids.delete(id)
      end 

      block = Hotel::Block.new(date_range, rooms: rooms) 

      @blocks << block
      return block
    end 


    def available_blocks(date_range, number_of_rooms:)
      return @blocks.find_all do |block|
        block.date_range.same?(date_range) && (block.rooms.length == number_of_rooms)
      end 
    end 


    def make_block_reservation(date_range, number_of_rooms: 1)

      if (number_of_rooms < 1) || (number_of_rooms > 5)
        raise ArgumentError, "A block can contain a maximum of 5 rooms"
      end 

      available_blocks = self.available_blocks(date_range, number_of_rooms: number_of_rooms)

      if available_blocks.empty?
        raise ArgumentError, "There is no available block within the specific date range"
      end 

      # Create instances of Reservation (block)
      block_reservation = Reservation.new(date_range, block: available_blocks[0])

      self.add_reservation(block_reservation, type: :block)
      @blocks.delete(available_blocks[0]) 
      
      return block_reservation
    end 


    def find_block_reservations(date_range)
      return @reservations[:block].find_all do |reservation|
          (reservation.date_range.same?(date_range)) && (reservation.block)
      end 
    end 


    # Helper method
    def add_reservation(reservation, type: :individual)
      if type == :individual 
        @reservations[:individual] << reservation 
      elsif type == :block 
        @reservations[:block]<< reservation 
      end 
    end
    
    def find_room_by_id(number)
      return @rooms.find { |room| room.id == number}
    end 
  end 
end 