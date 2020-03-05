
module Hotel
  class ReservationManager
    attr_reader :all_rooms, :all_reservations

    def initialize
      @all_rooms = Hotel::Room.all
      @all_reservations = Array.new
    end

    # Find available room with date
    def available?(start_date, end_date, room)
      room.reservations.each do |reservation|

        start_date = Date.parse(start_date)
        end_date = Date.parse(end_date)

        while start_date != end_date
          return false if (reservation.start_date..reservation.end_date - 1).include?(start_date)
          start_date += 1          
        end
      end
      return true
    end

    # List available rooms
    def available_rooms(start_date, end_date)
      list_available_rooms = Array.new
      all_rooms.each do |room|
        result = available?(start_date, end_date, room)
        if result
          list_available_rooms << room
        end
      end        
      return list_available_rooms
    end

    # Make a new reservation
    def make_reservation(start_date, end_date)
      id = all_reservations.length + 1
      room = all_rooms[0]
      reservation = Hotel::Reservation.new(id, room, start_date, end_date)
      all_reservations << reservation
      room.reservations << reservation
      return reservation
    end

    # Look-up a reservation by date
    def find_reservation(date)
      by_date_reservation = all_reservations.select do |reservation|
        #reservation.start_date == Date.parse(date)
        start_date = reservation.start_date
        end_date = reservation.end_date - 1
        (start_date..end_date).include? (Date.parse(date))
      end
      return by_date_reservation
    end
  end
end