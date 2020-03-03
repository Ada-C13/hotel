module Hotel
  class HotelReception
    attr_accessor :rooms, :reservations

    def initialize
      @rooms = []
      @reservations = []
      20.times do |i|
        i += 1
        @rooms << i
      end
    end

    def reservations_by_room_date(room, date)
      my_reservations = reservations.select { |res| res.room_id == room }
      return my_reservations.difference(self.reservations_by_date(date))
    end

    def reservations_by_date(date)
      date = Date.new(date[0], date[1], date[2]) unless date.class == Date
      return reservations.select { |res| res.date_range.include?(date) }
    end

    def find_reservation(id)
      return reservations.find { |res| res.id == id }
    end

    def available_rooms(check_in_time, check_out_time)
      #returns an array of room numbers that are available on a given date
      dates = Hotel::DateRange.new(check_in_time, check_out_time)

      # unavail_rooms = reservations.map { |res| res.room_id if res.date_range.overlap?(dates) }

      unavail_rooms = []
      #for this day, do they overlap?
      reservations.each do |res|
        unavail_rooms << res.room_id if res.date_range.overlap?(dates)
      end
      return rooms.difference(unavail_rooms)               
    end

    def make_reservation(check_in_time, check_out_time)
      room_id = available_rooms(check_in_time, check_out_time).first
      @reservations << Hotel::Reservation.new(check_in_time, check_out_time, room_id)
      return reservations.last
    end
  end
end