require_relative 'room'
require_relative 'date_range'
require_relative 'reservation'

module Hotel
  class SystemCoordinator    
    attr_reader :rooms

    def initialize(room_quantity = 20)
      @rooms = build_rooms(room_quantity)
    end

    def build_rooms(quantity)
      Array.new(quantity){|i| Hotel::Room.new(i+1)}
    end

    def list_rooms
      return @rooms
    end

    # below method needs to also show me the reservations made from hotel block
    def find_reservations_by_date(date)
      reservations_by_date = []

      @rooms.each do |room|
        room.bookings.each do |reservation|
          reservations_by_date << reservation if reservation.date_range.include_date(date)
        end
      end

      return reservations_by_date
    end

    def find_reservations_room_date(room_id, date_range)
      selected_room = find_room(room_id)
      reservations_room_date = selected_room.bookings.select{|reservation|reservation.date_range.overlapping(date_range)}
      return reservations_room_date    #what returns if no match?
    end

    def find_reservations_range(given_range)
      reservations_range = []

      @rooms.each do |room|
        room.bookings.each do |reservation|
          reservations_range << reservation if reservation.date_range.overlapping(given_range)
        end
      end

      return reservations_range
    end

    def find_availabile_rooms(given_range)
      available_rooms = @rooms.reject do |room|
        room.bookings.any? do |reservation|   #returns true if there are overlapping reservations
          reservation.date_range.overlapping(given_range) == true
        end
      end

      return available_rooms
    end

    def find_room(given_room_id)
      room_found = @rooms.find{|room|room.room_id == given_room_id}
      return room_found
    end
   
    def make_reservation(start_date, end_date)
      range_created = Hotel::DateRange.new(start_date,end_date)
      available_rooms = find_availabile_rooms(range_created)
      raise ArgumentError if available_rooms == []
      
      chosen_room = available_rooms.shift
      new_reservation = Hotel::Reservation.new(range_created, chosen_room.room_id)
 
      chosen_room.add_booking_to_room(new_reservation)

      return new_reservation
    end
  end
end


      # handle/ rescue exceptions 
      # edge cases i.e. what happens if no match?

      # what returns if no match?!!!!! rescue an raised exception????????
      # I want an exception raised if I try to reserve a room during a date range when all rooms are reserved, 
      # so that I cannot make two reservations for the same room that overlap by date
      # I want exception raised when an invalid date range is provided, 
      # so that I can't make a reservation for an invalid date range