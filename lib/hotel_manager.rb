require_relative 'reservation'
require_relative 'date_range'
require_relative 'room'

module Hotel 
  class HotelManager 

    ROOM_NUMBERS = 20 

    attr_reader :rooms, :reservations 

    def initialize
      @rooms = []
      @reservations = []

      ROOM_NUMBERS.times do |i| 
        @rooms << Hotel::Room.new(i + 1)
      end 
    end 

    # (1)list of reservations with a given date range & room => returning reservation
    #  overlap (booking)
    def reservations_per_room(date_range, room)
      return @reservations.select do |reservation| 
        # If the room number is the same
        # check the reservation inside of the room 
        (reservation.room.number == room.number) && (reservation.date_range.overlap?(date_range))
      end 
    end 

    
    # (2) Find available rooms (with given date range) 
    #  and use the "reservations_per_room" from (1)
    def available_room_numbers(date_range) 
 
      # Find available rooms that are not reserved for the given date range
      available_rooms = @rooms.select do |room| 
        reservations = reservations_per_room(date_range, room)
        reservations.empty?
      end 

      # Return room numbers
      return available_rooms.map { |room| room.number }
    end 


    # (3) make reservation
    # if we have available rooms, create a new instance of Reservation
    # if not, room is not available 
    def make_reservation(date_range)

      # Find available rooms for the specific date range
      available_room_numbers = available_room_numbers(date_range) 

      # If available_rooms exist
      if available_room_numbers.length > 0 

        # Create an instance of Reservation
        room = find_room_by_number(available_room_numbers[0])
        reservation = Reservation.new(date_range, room)
        
        self.add_reservation(reservation)

        return reservation
      end 
  
      raise ArgumentError, "There are no available rooms"
    end 


    # (4) Find reservations for date => include (searching)
    # iterate through reservations
    def find_all_reservations(date)

      list = @reservations.filter do |reservation|
        # modified
        reservation.date_range.include?(date) #end_date should be excluded
      end 

      # TO DO
      # Make a custom error
      if list.empty? 
        raise ArgumentError, "No reservations found"
      end 

      return list
    end 


    # Helper method
    def add_reservation(reservation)
      @reservations << reservation
    end
    
    # TO DO
    # add test
    def find_room_by_number(number)
      return @rooms.find { |room| room.number == number}
    end 
  end 
end 