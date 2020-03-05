require 'date'
require_relative 'room'
require_relative 'date_range'
require_relative 'reservation'

module Hotel
  class FrontDesk
    attr_reader :num_rooms, :reservations, :rooms
    
    def initialize(num_rooms)
      @num_rooms = num_rooms
      valid_number_of_rooms
      
      @rooms = []
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
    
    
    def find_room_by_number(room_number)
      room = @rooms.select { |room| room.room_number == room_number }
      
      return room.first
    end
    
    
    # This method is created and used in multi-hour collaboration and conversation with Cathy (and Nikki-by-proxy)
    def list_available_rooms(check_in, check_out)
      available_rooms = []
      
      new_range = Hotel::DateRange.new(check_in, check_out)
      
      available_rooms = @rooms.reject do |room|
        room.reservations.any? do |reservation|
          reservation.date_range.overlap?(new_range) == true
        end
      end
      
      return available_rooms
    end
    
    # TODO: Make more tests for this method
    # Need to look into assigning reservation to room      
    def create_reservation(check_in, check_out)
      date_range = Hotel::DateRange.new(check_in, check_out)
      
      all_available_rooms = list_available_rooms(check_in, check_out)
      
      available_room = all_available_rooms[0]
      
      room_number = available_room.room_number
      
      reservation = Hotel::Reservation.new(date_range)
      reservation.room_number = room_number
      
      # add reservation to room collection of reservations
      available_room.reservations << reservation
      
      return reservation
    end  
  end
end
