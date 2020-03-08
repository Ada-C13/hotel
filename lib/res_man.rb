require "date"

module Stayappy
  class ReservationManager 
    attr_reader :all_rooms, :available_rooms, :unavailable_rooms, :bookings, :stay, :room_num

    attr_accessor :reservation

    def initialize
      @all_rooms = (1..20).to_a
      @available_rooms = (1..20).to_a
      @unavailable_rooms = []
      @bookings = []
    end 

    # Method to take a valid date request and assign a room to it.
    def assign_room
      if available_rooms.length >= 1
        room_num = available_rooms.shift
        unavailable_rooms << room_num
      end
      if available_rooms.length < 1
        raise ArgumentError.new("The hotel is full during that reservation window.")
      end
      room_num
    end

    # Method to hold each visit in the bookings book
    def book_of_bookings(reservation)
      bookings << reservation
      bookings 
    end

    def res_num_generator
      bookings.length 
    end

    def make_reservation(stay)
      #Add code to:
      #-assign a room
      #-change the status of that room for those dates
      #Control flow for regular reservation or block_reservation, in terms of total cost for a reservation
      res_num = res_num_generator 

      reservation.date_vet(stay)
      assign_room(stay)
      book_of_bookings(reservation) 
      reservation
    end

    def reservations_by_date
      #Add code to show the hotel's reservations for a given date/date range
      date_searched_for = Date.new
      that_dates_reservations = []
      if book_of_bookings.include?(date_searched_for)
        that_dates_reservations << date_searched_for 
      end
      that_dates_reservations
    end

    def reservations_by_room
      #Add code to show the reservations by room number
      room_searched_for = room_num
      that_rooms_reservations = []
      if book_of_bookings.include?(room_searched_for)
        that_rooms_reservations << room_searched_for
      end
      that_rooms_reservations
    end

  # def view_vacancy 
  #   #Store rooms in collections for given dates
  # end 

  # def view_occupancy
  #   #Store rooms in collections for given dates
  # end

  # def view_all
  #   #Store all rooms, both vacant and occupied 
  # end 
  end

end 