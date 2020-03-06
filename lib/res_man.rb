require "date"

module Stayappy
  class ReservationManager 
    attr_reader 

    all_rooms = (1..20).to_a
    available_rooms = (1..20).to_a
    unavailable_rooms = []
    bookings = []


    def make_reservation
      #Add code to:
      #-assign a room
      #-change the status of that room for those dates
    end

    def view_vacancy 
      #Store rooms in collections for given dates
    end 

    def view_occupancy
      #Store rooms in collections for given dates
    end

    def view_all
      #Store all rooms, both vacant and occupied 
    end 

    def reservations_by_date
      #Add code to show the hotel's reservations for a given date/date range
    end

    def reservations_by_room
      #Add code to show the reservations by room number
    end
  end
end 