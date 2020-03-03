require_relative 'room'
require_relative 'date_range'

module Hotel
  class SystemCoordinator    
    attr_reader :rooms
    # SystemCoordinator should know rooms

    def initialize
      @rooms = Array.new(20){|i| Hotel::Room.new(i+1)} #access the list of all of the rooms in the hotel
    end

        # [method] track reservation by date to find list of reservations for a specific date
    def find_reservation_by_date (date)
      
    end
   

    # method to make reservation
    # def make_reservation(start_date, end_date)
    #   date_range = Hotel::DateRange.new(start_date,end_date)
    #   room_id = 1
    #   reservation = Hotel::Reservation.new(date_range, room_id)
    #   return reservation

    # end

    

    # # many methods
    # # method to make reservation
    # def make_reservation(start_date, end_date)

    # # [method] track reservation by date to find list of reservations by date
    # def find_reservation_by_date (date)
    #   def find_reservation_date (start_date, end_date)
    #   can access the list of reservations for a specific date


    # [method] access the list of reservations for a specified room and a given date range
    # def find_reservation_room_date(room_id, date_range)
    
    # [method] avail rooms for that day. I can view a list of rooms that are not reserved for a given date range
    # def find_availabile_rooms(date_range)

    # handle/ rescue exceptions when there is no availability


  end
end