require_relative 'room'
require_relative 'date_range'
require_relative 'reservation'

module Hotel
  class SystemCoordinator    
    attr_reader :rooms, :reservations

    def initialize
      @rooms = Array.new(20){|i| Hotel::Room.new(i+1)} #access the list of all of the rooms in the hotel
      @reservations = []
    end

    def list_rooms
      return @rooms
    end

    # #method# track reservation by date to find list of reservations for a specific date
    def find_reservations_by_date (date)
      # what returns if no match
      reservations_by_date = @reservations.select{|reservation|reservation.date_range.include_date(date)}
      return reservations_by_date
    end

    # #method# access the list of reservations for a specified room and a given date range
    def find_reservations_room_date(room_id, date_range)
      # what returns if no match?!!!!
      reservations_room_date = @reservations.select{
        |reservation|reservation.room_id == room_id && reservation.date_range.overlapping(date_range)
      }
      return reservations_room_date
      # alternatively, we can search through the collection of rooms
      # selected_room = @rooms.find{|room|room.room_id == room_id}
      # reservations_room_date = selected_room.bookings.select{|reservation|reservation.date_range.overlapping(date_range)}
    end

    def find_reservations_range(given_range)
      # what returns if no match?!!!!!
      reservations_range = @reservations.select{|reservation|reservation.date_range.overlapping(given_range)}
      return reservations_range
    end

    # [method] avail rooms for that day. I can view a list of rooms that are not reserved for a given date range
    def find_availabile_rooms(given_range)
      available_rooms = []
      unavailabes = find_reservations_range(given_range)
      # what returns if no match?!!!!! rescue an raised exception????????
      unavailable_room_ids = unavailabes.map do |reservation|
        reservation.room_id
      end

      unavailable_room_ids.each do |id|
        available_rooms = @rooms.reject{|room|room.room_id == id}
      end

      return available_rooms
    end

    # method to find room
    def find_room(given_room_id)
      room_found = @rooms.find{|room|room.room_id == given_room_id}
      return room_found
    end
   
    # method to make reservation
    def make_reservation(start_date, end_date)
      range_created = Hotel::DateRange.new(start_date,end_date)
      available_rooms = find_availabile_rooms(range_created)
      # what returns if no match?!!!!! rescue an raised exception????????
      chosen_room_id = available_rooms[0].room_id
      chosen_room = find_room(chosen_room_id)
      new_reservation = Hotel::Reservation.new(range_created, chosen_room_id)
      
      @reservations << new_reservation
      chosen_room.add_booking_to_room(new_reservation)

      return new_reservation
    end

    # handle/ rescue exceptions 
    # edge cases
  end
end
