
module Hotel
  class ReservationManager
    attr_reader :all_rooms, :all_reservations

    def initialize
      @all_rooms = Hotel::Room.all
      @all_reservations = Array.new
    end

    def make_reservation(start_date, end_date)
      id = all_reservations.length + 1
      room = all_rooms[0]
      reservation = Hotel::Reservation.new(id, room, start_date, end_date)
      all_reservations << reservation
      room.reservations << reservation

      return reservation
    end
  end
end