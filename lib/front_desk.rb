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
    
    
    def reserve_room(start_date, end_date) 
      date_range = Hotel::DateRange.new(start_date, end_date)

      reservation = Hotel::Reservation.new(date_range, 1) # <== change this room number here to the room object
      # TODO:
      # update this in reservation, tests

      # get room object so you can add this to the collection of reservations

      # adds to collection of reservations
      
      # what to do with this reservation - add to room

    end
    
  end
end



# List all available rooms for a given date range - check given range against all ranges in all rooms
# def available_rooms_by_date_range(date_range)
#   available_rooms = []
#   unavailalbe_rooms = []
  
#   @rooms.each do |room|
#     room.reservations.each do |reservation|
#       if reservation.date_range.include?(date_range.start_date)
#         unavailalbe_rooms << room
#       else
#         available_rooms << room
#       end
#     end
#   end
#   return available_rooms
# end