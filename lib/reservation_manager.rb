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

        first_day = Date.parse(start_date)
        last_day = Date.parse(end_date)

        while first_day != last_day
          return false if (reservation.start_date...reservation.end_date).include?(first_day)
          first_day += 1          
        end
      end
      return true
    end

    # List available rooms
    def available_rooms(start_date, end_date)
      all_rooms.select { |room| available?(start_date, end_date, room) }     
    end

    # Make a new reservation
    def make_reservation(start_date, end_date)
      id = all_reservations.length + 1
      room = available_rooms(start_date, end_date)[0]
      raise StandardError if !room
        
      reservation = Hotel::Reservation.new(id, room, start_date, end_date)
      all_reservations << reservation
      room.reservations << reservation
      return reservation
    end

    # Look-up a reservation by date
    def find_reservation(date)
      all_reservations.select do |reservation|
        first_day = reservation.start_date
        last_day = reservation.end_date
        (first_day...last_day).include? Date.parse(date)
      end
    end
  end
end