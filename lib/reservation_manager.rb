
module Hotel
  class ReservationManager
    attr_reader :all_rooms, :all_reservations

    def initialize
      @all_rooms = Hotel::Room.all
      @all_reservations = Array.new
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
      day_reservation = all_reservations.select do |reservation|
        #reservation.start_date == Date.parse(date)
        start_date = reservation.start_date
        end_date = reservation.end_date - 1
        (start_date..end_date).include? (Date.parse(date))
      end
      return day_reservation
    end

  end
end