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
    
    # this method returns an array of rooms that are available by using the overlap? method
    # if overlap check returns false, put that room in available
    def list_available_rooms(check_in, check_out)
      available_rooms = []
      
      new_range = Hotel::DateRange.new(check_in, check_out)
      
      @rooms.each do |room|
        if room.reservations.empty?
          available_rooms << room
          # look into "next"/"break"
        end
        
        room.reservations.each do |current_reservation|
          if current_reservation.daterange.overlap?(new_range) == false
            available_rooms << room
          end
        end
      end
      
      return available_rooms
    end
    

    #TODO: Make tests
    def find_room_for_reservation(start_date, end_date)
      
    end
    
    
    # TODO: Make some tests!
    # Make room_number optional in reservation init
    # call method to list_all_available_rooms, shovel reservaiton object to the first available room
    
    # change this to create_reservation
    # call list_available_rooms
    def create_reservation(check_in, check_out)
      date_range = Hotel::DateRange.new(check_in, check_out)
      
      rooms_avail = list_available_rooms(check_in, check_out)

      room_number = rooms_avail[0].room_number

      reservation = Hotel::Reservation.new(date_range)
      reservation.room_number = room_number
      
      return reservation
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