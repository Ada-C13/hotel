
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

    
    def get_available_rooms(date_range)
      unavailable_rooms = []
      # Send the room to unavailable rooms if has a reservation for a specific data_range. 
      @reservations.each do |reservation|
        if reservation.daterange.overlap?(date_range) == true
          unavailable_rooms << reservation.room
        end
      end
      # Array substrating total_rooms minus unavailable rooms.
      available_rooms = @rooms - unavailable_rooms
      return available_rooms
    end

    def reservations_by_room_date (room, date_range)
      # Rooms contains all the reservations match based on the room given. 
      rooms = @reservations.select do |reveservation|
        reveservation.room.room_id == room
      end
      reservations_by_room = rooms.select do |reservation|
        reservation.daterange == date_range
      end

      if reservations_by_room.empty?
        raise ArgumentError
      end

      return reservations_by_room
    end

    def reservations_by_date(date)
      total_by_date =  @reservations.select do |reservation|
        reservation.daterange.start_date == date
      end

      if total_by_date.empty?
        raise ArgumentError
      end
      return total_by_date
    end

    def cost_by_reservation(reservation_number)
      cost = nil
      @reservations.each do |reservation|
         if reservation.id == reservation_number
          cost = reservation.total_cost
         end
       end
       return cost
     end

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