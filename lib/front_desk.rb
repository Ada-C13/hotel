require 'date'
require_relative 'room'
require_relative 'date_range'
require_relative 'reservation'
require_relative 'no_rooms_error'
require_relative 'reservation_block'

module Hotel
  class FrontDesk
    attr_reader :num_rooms, :reservations, :rooms
    
    def initialize(num_rooms)
      @num_rooms = num_rooms
      valid_number_of_rooms
      
      @rooms = []
      build_rooms
      @blocks = []
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
    
    
    def find_reservations_by_room(room_number)
      room = find_room_by_number(room_number)
      
      reservations = room.reservations 
      
      if reservations == nil
        return []
      end
      
      return reservations
    end
    
    
    # This method was created in multi-hour collaboration/conversation with Cathy (and Nikki-by-proxy) - props to Nikki's genius brain!!
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
    
    
    def find_available_room(check_in, check_out)
      all_rooms = list_available_rooms(check_in, check_out)
      
      if all_rooms.empty?
        raise NoAvailableRoomsError.new("No rooms available for the specified date.")
      end
      
      return all_rooms[0]
    end
    
    
    def check_for_blocks(check_in, check_out, room_number)
      potential_range = Hotel::DateRange.new(check_in, check_out)
      
      possible_overlaps = @blocks.select { |block| block.rooms.include?(room_number) }
      
      if possible_overlaps.empty?
        return true
      else
        possible_overlaps.reject! do |block|
          block.date_range.overlap?(potential_range) == true
        end
      end
      
      if possible_overlaps.empty?
        raise NoAvailableRoomsError.new("This room is part of a block and cannot be reserved for this date")
      end
      
      return true
    end
    
    
    def create_reservation(check_in, check_out)
      room = find_available_room(check_in, check_out)
      
      room_number = room.room_number
      
      date_range = Hotel::DateRange.new(check_in,check_out)
      
      reservation = Hotel::Reservation.new(date_range)
      
      reservation.room_number = room_number
      
      check_for_blocks(check_in, check_out, room_number)
      
      room.reservations << reservation
      
      return reservation
    end  
    
    
    def reservations_by_date(date)
      reservations_on_date = []
      
      @rooms.each do |room|
        room.reservations.each do |reservation|
          if reservation.date_range.date_in_range?(date)
            reservations_on_date << room
          end
        end
      end
      
      return reservations_on_date
    end
    
    
    def create_block(daterange, discount, rooms)
      
      available_for_block?(rooms, daterange)
      
      block = Hotel::Block.new(daterange, discount, rooms: rooms)
      
      @blocks << block
    end
    
    
    def available_for_block?(rooms, daterange) # takes collection
      
      rooms.each do |room_num| # look at each room number
        reservations = find_reservations_by_room(room_num) # returns an array of reservations
        
        reservations.each do |reservation|
          if reservation.date_range.overlap?(daterange) # if this returns true
            raise NoAvailableRoomsError.new("This block is not available for this date range.")
          end
        end
      end
      
      return true
    end
    
  end   
end
