require 'date'
require 'room'

module Hotel
  class FrontDesk
    attr_reader :num_rooms, :reservations, :rooms
    # attr_accessor 
    
    def initialize(num_rooms)
      @num_rooms = num_rooms
      
      valid_number_of_rooms

      @rooms = [] # array of room objects
      @reservations = [] # array of reservation objects
      
      build_rooms
    end
    

    def valid_number_of_rooms
      if @num_rooms < 0
        raise ArgumentError.new("Number of rooms must be positive")
      end
    end


    def build_rooms
      room_number = 1
      @num_rooms.times do
        room = Hotel::Room.new(room_number.to_s)
        @rooms << room
        room_number += 1
      end
    end
  
    
    # List all reservations
    
    # List all rooms
    
    # List all available rooms for a given date range - check given range against all ranges in all rooms
    
    # method to add something to the collection of reservations (invoked in reservation)?
    
    # reserve_room: given dateRange, reserve next available room object
    
    # check_available: given dateRange, state what rooms from the collection of rooms are available (don't have any instance of date within their date range)
    
    # set a room block(number of rooms, discounted rate/percentage)
    
    
    
  end
end