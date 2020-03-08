require_relative "room"
require_relative "date_range"
require_relative "reservation"
require_relative "no_room_available"


module Hotel
  class HotelController
    # attr_reader :rooms
    attr_accessor :reservations
    attr_reader :rooms

    def initialize
      @rooms = Array.new(20){|i| Hotel::Room.new(i+1)}
      @reservations = []
    end

    #I can access the list of reservations for a specific date, so that I can track reservations by date
    def reservation(date)
      result = []
      @reservations.each do |reservation|
        if reservation.date_range.include?(date)
          result << reservation
        end
      end
      return result
    end

    # Cost for giving reservation
    def total_cost(reservation)
      total_cost = reservation.cost
      return total_cost
    end
    
    #Make new reservation
    def reserve_room(start_date, end_date)
      avalable_room = available_rooms(start_date, end_date)
      raise NoRoomAvailable.new ("No room available") if avalable_room == []
      
      new_restervation = Hotel::Reservation.new(start_date, end_date, avalable_room.first)
      reservations << new_restervation
      return new_restervation
    end

    #I access the list of reservations for a specified room and a given date range
    def reservations_for_room(date_range, room)
      result = []
      reservations.each do |reservation|
        if reservation.date_range.overlap?(date_range) && room.room_nr == reservation.room.room_nr
          result << reservation
        end
      end
      return result
    end


    def available_rooms(start_date, end_date)
      unavalable_room = []
      another_range = Hotel::DateRange.new(start_date, end_date)

      @reservations.each do |reservation|
        if reservation.date_range.overlap?(another_range) 
          unavalable_room << reservation.room 
        end
      end 
      
      avalable_room = @rooms - unavalable_room
      return avalable_room
    end

  end
end
