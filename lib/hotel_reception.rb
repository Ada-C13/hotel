module Hotel
  class HotelReception
    attr_accessor :rooms, :reservations

    def initialize
      @rooms = []
      @reservations = []
      20.times do |i|
        i += 1
        @rooms << Hotel::Room.new(i, 200)
      end
    end

    def find_reservation(id)
      return reservations.find { |res| res.id == id }
    end

    def available_rooms(check_in_time, check_out_time)
      dates = Hotel::DateRange.new(check_in_time, check_out_time)
      #find the reservations that overlap with my date range
      unavail = reservations.select { |res| res.date_range.overlap?(dates) }
      #alter the array so that it is made up of the rooms that are unavailable
      unavail.map! { |res| res.room }
      #return an array of the rooms that are left when the reserved rooms are subtracted
      return rooms.difference(unavail)
      # reservations.reject { |res| res.date_range.overlap?(dates) }
    end
    
    def list_reservations(date:, room_id: nil)
      date = Date.new(date[0], date[1], date[2]) unless date.class == Date
      res_by_date = reservations.select { |res| res.date_range.include?(date) }
      if room_id
        res_by_room = reservations.select { |res| res.room.id == room_id }
        res_by_room.map! { |res| res.room.id }
        return res_by_date.difference(res_by_room)
      else
        return res_by_date
      end
    end

    def make_reservation(check_in_time, check_out_time)
      room = available_rooms(check_in_time, check_out_time).first
      if room
        @reservations << Hotel::Reservation.new(check_in_time, check_out_time, room)
        return reservations.last
      else
        raise ArgumentError, "There are no rooms available on that date."
      end
    end
  end
end