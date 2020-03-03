require 'date'
require 'room'

module Hotel
  class FrontDesk
    attr_reader :num_rooms, :reservations, :rooms
    # attr_accessor 
    
    def initialize(num_rooms)
      @num_rooms = num_rooms
      
      @rooms = [] # array of room objects
      @reservations = [] # array of reservation objects
      
      build_rooms
    end
    

    def build_rooms
      room_number = 1
      @num_rooms.times do
        room = Hotel::Room.new(room_number.to_s)
        @rooms << room
        room_number += 1
      end
    end
    
    # add method for validating number of rooms
    
    # how to initialize a room
    # def initialize(room_number, reservations: [], cost: 200)
    #   @room_number = room_number
    #   @reservations = reservations
    #   # holds collection of reservation objects for this specific room (with dates) - this could be how to check for reservations
    #   @cost = cost
    
    #   valid_room_number
    # end
    
    # make room objects method
    
    # List all reservations
    
    # List all rooms
    
    # List all available rooms for a given date range - check given range against all ranges in all rooms
    
    # method to add something to the collection of reservations (invoked in reservation)?
    
    # reserve_room: given dateRange, reserve next available room object
    
    # check_available: given dateRange, state what rooms from the collection of rooms are available (don't have any instance of date within their date range)
    
    # set a room block(number of rooms, discounted rate/percentage)
    
    
    
  end
end