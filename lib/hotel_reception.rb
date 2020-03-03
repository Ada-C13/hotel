module Hotel
  class HotelReception
    attr_reader :rooms, :reservations

    def initialize
      @rooms = []
      @reservations = []
      20.times do |i|
        i += 1
        @rooms << {room_id: i}
      end
    end

    def reservations_by_room_date(room_id, date)
      date = Date.new(date[0], date[1], date[2]) unless date.class == Date
      return reservations.select { |reservation| reservation.room == room_id && reservation.date_range.days.include?(date)}
    end

    def reservations_by_date(date)
      date = Date.new(date[0], date[1], date[2]) unless date.class == Date
      return reservations.select { |reservation| reservation.date_range.days.include?(date) }
    end

    def find_reservation(id)
      return reservations.find { |reservations| reservations.id == id }
    end

    def available_rooms
      reserved_rooms = reservations.map { |reservation| reservation.room_id }
      return rooms.difference(reserved_rooms)
    end

    def make_reservation(check_in_time, check_out_time)
      #find free room
      room_id = available_rooms.first
      @reservations << Reservation.new(check_in_time, check_out_time, room_id)
      return reservations.last
    end
  end
end