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
      @reservations = []
      
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
    
    # could use this to pass room objects rather than just the id_number
    def find_room_by_number(room_number)
      room = @rooms.select { |room| room.room_number == room_number }

      return room.first
    end
    
    
    # this may need to take in a room object rather than number?
    def reserve_room(date_range, room_number) 
      # sets new id number
      if @reservations.empty?
        reservation_id = 1
      else
        reservation_id = @reservations.last.reservation_id + 1
      end
      
      # makes new instance of reservation
      reservation = Hotel::Reservation.new(reservation_id, date_range, room_number)
      
      # need a method for returning which room is available to be rented - seems like returning the first instance of available room through available_rooms_by_date_range is the best way to do this
      
      # adds to collection of reservations
      @reservations << reservation
    end
    
    
    # List all available rooms for a given date range - check given range against all ranges in all rooms
    # def available_rooms_by_date_range(date_range)
    #   available_rooms = []
    #   unavailalbe_rooms = []
      
    #   @rooms.each do |room|
    #     room.reservations.each do |reservation|
    #       if raservation.date_range.include?(date_range)
    #         unavailalbe_rooms << room
    #       else
    #         available_rooms << room
    #       end
    #     end
    #   end
    #   return available_rooms
    # end
    
    
    # set a room block(number of rooms, discounted rate/percentage)
    
    
    
  end
end