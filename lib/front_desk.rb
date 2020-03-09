
module Hotel
  class FrontDesk
    attr_reader :rooms, :date_range, :reservations

    def initialize
      @rooms = generate_rooms
      @reservations = []
    end
  
    def generate_rooms
      hotel_rooms = Array.new
        (1..20).each do |room_id|
          hotel_rooms << Room.new(room_id)
      end
      return hotel_rooms
    end

    def room_list
      return @rooms
    end

    def total_reservations
      return @reservations
    end

    # list of rooms that are not reserved for a given date range, 
    # so that I can see all available rooms for that day.
    # It retuns an arrary with rooms with not reservations with a given date.
    def get_available_rooms(date_range)
      unavailable_rooms = []
      # Send the room to unavailable rooms if room has a reservation for a specific data_range. 
      @reservations.each do |reservation|
        if reservation.daterange.overlap?(date_range) == true
          unavailable_rooms << reservation.room
        end
      end
      # Array substrating total_rooms minus unavailable rooms.
      return @rooms - unavailable_rooms
    end

    # The list of reservations for a specified room and a given date range.
    # room = room_i d.
    # date_range = data_range instance.
    # It returns an array of reservation.
    def reservations_by_room_date (room_number, date_range)
      # reservations_by_room contains all the reservations match
      # based on the room and a given date range. 
      reservations_by_room = @reservations.select do |reservation|
        reservation.room.room_id == room_number &&
        reservation.daterange.overlap?(date_range)
      end
      return reservations_by_room
    end

    # It returns an array with the list of reservations for a specific date.
    # date = date instance.
    def reservations_by_date(date)
      total_by_date =  @reservations.select do |reservation|
        reservation.daterange.start_date == date
      end
      return total_by_date
    end

    # Get the total cost for a given reservation
    # reservation_number = reservartion_id
    # It returns nil if reservation id not found.
    def cost_by_reservation(reservation_number)
      @reservations.each do |reservation|
         if reservation.id == reservation_number
          return reservation.total_cost
         end
       end
       return nil
     end

    # Make a reservation of a room for a given date range,
    # and that room will not be part of any other reservation overlapping that date range
    # an exception raised if I try to reserve a room during a date range when all rooms are reserved.
    def make_resevation(date_range)
      available_rooms = get_available_rooms(date_range)
      if available_rooms.length < 1
        raise ArgumentError
      end
      new_reservation = Hotel::Reservation.new(date_range,available_rooms[0])
      @reservations << new_reservation
      return new_reservation
    end
  end
end