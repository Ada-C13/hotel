module Hotel
  class HotelReception
    attr_reader :rooms, :reservations

    def initialize
      @rooms = []
      @reservations = []
      20.times do |i|
        i += 1
        @rooms << i
      end
    end

    def reservations_by_room_date(room_id, date)
      my_reservations = reservations.select { |reservation| reservation.room == room_id }
      return my_reservations.difference(self.reservations_by_date(date))
    end

    def reservations_by_date(date)
      date = Date.new(date[0], date[1], date[2]) unless date.class == Date
      return reservations.select { |reservation| reservation.date_range.days.include?(date) }
    end

    def find_reservation(id)
      return reservations.find { |reservations| reservations.id == id }
    end

    def available_rooms(check_in_time, check_out_time)
      date_range = DateRange.new(check_in_time, check_out_time)

      reserved_rooms = reservations.select { |reservation| reservation.room_id if reservation.date_range.overlap?(date_range) }
      return reserved_rooms
    end

    def make_reservation(check_in_time, check_out_time)
      room_id = available_rooms(check_in_time, check_out_time).first
      @reservations << Reservation.new(check_in_time, check_out_time, room_id)
      return reservations.last
    end
  end
end