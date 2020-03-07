require_relative 'reservation'
require_relative 'date_range'
require_relative 'room'

module Hotel 
  class HotelManager 

    ROOM_NUMBERS = 20 
    ROOM_TYPES = ["all", "individual", "regular", "block", "blocks"]

    attr_reader :rooms, :reservations 

    def initialize
      @rooms = []
      @reservations = []
      @blocks = []

      ROOM_NUMBERS.times do |i| 
        @rooms << Hotel::Room.new(id: i + 1)
      end 
    end 

    # (1)list of reservations with a given date range & room => returning reservation
    #  overlap (booking)
    def reservations_per_room(date_range, room)
      return @reservations.select do |reservation| 
        # If the room number is the same
        # check the reservation inside of the room 
        (reservation.room.id == room.id) && (reservation.date_range.overlap?(date_range))
      end 
    end 

    
    # (2) Find available rooms (with given date range) 
    #  and use the "reservations_per_room" from (1)
    def available_room_ids(date_range) 
 
      # Find available rooms that are not reserved for the given date range
      available_rooms = @rooms.select do |room| 
        reservations = reservations_per_room(date_range, room)
        reservations.empty?
      end 

      # Return room numbers
      return available_rooms.map { |room| room.id }
    end 


    # (3) make reservation
    # if we have available rooms, create a new instance of Reservation
    # if not, room is not available 
    def make_reservation(date_range)

      # Find available rooms for the specific date range
      available_room_ids = available_room_ids(date_range)
      
      if available_room_ids.empty? 
        raise ArgumentError, "There are no available rooms"
      end 

      # Create an instance of Reservation
      room = find_room_by_number(available_room_ids[0])
      reservation = Reservation.new(date_range, room)
      
      self.add_reservation(reservation)

      return reservation
    end 


    def make_block_reservation(date_range, number_of_rooms: 2)
      if (number_of_rooms < 2) || (number_of_rooms > 5)
        raise ArgumentError, "A block can contain between 2 and 5 rooms (a maximum of 5 rooms)"
      end

      # Find available rooms for the specific date range
      available_room_ids = available_room_ids(date_range)
      
      # TO DO (make a custom error)
      # If available_room_ids are less than the number_of_room, throw an error
      if available_room_ids.length < number_of_rooms
        raise ArgumentError, "There are no available rooms for #{number_of_rooms}. We have only #{available_room_ids.length} between #{date_range.start_date} and #{date_range.end_date} you chose"
      end 

      # Create instances of Reservation (block)
      rooms = []
      reservations = []

      number_of_rooms.times do |i|
        room = find_room_by_number(available_room_ids[i])
        reservation = Reservation.new(date_range, room, is_block: true)
        self.add_reservation(reservation)

        rooms << room
        reservations << reservation
      end 

      block_reservation = Hotel::Block.new(date_range, rooms, reservations)
      @blocks << block_reservation
      
      return block_reservation
    end 


    # (4) Find reservations for date => include (searching)
    # iterate through reservations
    def find_all_reservations(date, room_type: "all")
      !room_type.downcase

      if !ROOM_TYPES.include?(room_type)
        raise ArgumentError, "#{room_type} is an invalid value"
      end 

      if room_type == "all"
        return @reservations.find_all do |reservation|
          # modified
          reservation.date_range.include?(date) #end_date should be excluded
        end 
      elsif room_type == "block" || room_type == "blocks"
        return @reservations.filter do |reservation|
          (reservation.date_range.include?(date)) && (reservation.is_block == true)
        end 
      elsif room_type == "individual" || room_type == "regular"
        return @reservations.filter do |reservation|
          (reservation.date_range.include?(date)) && (reservation.is_block == false)
        end 
      end 
    end 

    # Helper method
    def add_reservation(reservation)
      @reservations << reservation
    end
    
    # TO DO
    # add test
    def find_room_by_number(number)
      return @rooms.find { |room| room.id == number}
    end 
  end 
end 


# p "find_all_reservations(Date.new(2020, 11, 11))"

# p Hotel::HotelManager.new().find_all_reservations(Date.new(2020, 11, 11))