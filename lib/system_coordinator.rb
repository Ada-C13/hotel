require_relative 'room'
require_relative 'date_range'

module Hotel
  class SystemCoordinator    
    attr_reader :rooms, :reservations
    # SystemCoordinator should know rooms

    def initialize
      @rooms = Array.new(20){|i| Hotel::Room.new(i+1)} #access the list of all of the rooms in the hotel
      @reservations = []
    end

    # #method# track reservation by date to find list of reservations for a specific date
    def find_reservations_by_date (date)
      # what returns if no match
      reservations_by_date = @reservations.select{|reservation|reservation.date_range.include_date(date)}
      return reservations_by_date
    end

    # #method# access the list of reservations for a specified room and a given date range
    def find_reservations_room_date(room_id, date_range)
      # what returns if no match
      reservations_room_date = @reservations.select{
        |reservation|reservation.room_id == room_id && reservation.date_range.overlapping(date_range)
      }
      return reservations_room_date
      # alternatively, we can search through the collection of rooms
      # selected_room = @rooms.find{|room|room.room_id == room_id}
      # reservations_room_date = selected_room.bookings.select{|reservation|reservation.date_range.overlapping(date_range)}
    end

    # [method] avail rooms for that day. I can view a list of rooms that are not reserved for a given date range
    # def find_availabile_rooms(date_range)

    # end
   

    # method to make reservation
    # def make_reservation(start_date, end_date)
    #   date_range = Hotel::DateRange.new(start_date,end_date)
    #   room_id = 1
    #   new_reservation = Hotel::Reservation.new(date_range, room_id)
    #   @reservations << new_reservation
    #  push new reservation into room reservation container 
    #   return new_reservation

    # end

    

    # # many methods
    # # method to make reservation
    # def make_reservation(start_date, end_date)

    
    # [method] avail rooms for that day. I can view a list of rooms that are not reserved for a given date range
    # def find_availabile_rooms(date_range)

    # handle/ rescue exceptions when there is no availability


  end
end