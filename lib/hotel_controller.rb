module Hotel
  class HotelController
    attr_reader :rooms, :reservations

    def initialize
      @rooms = []
      @reservations = []
    end

    def add_room(room)
      @rooms << room
    end

    def list_of_all_rooms
      return @rooms
    end

    def reserve_room(arrive, depart)
      raise ArgumentError, "End date must be after start date" if depart < arrive || depart == arrive
      @reservations << Hotel::Reservation.new(arrive, depart)
      return Hotel::Reservation.new(arrive, depart)
    end

    def list_reservations(given_date:, second_date: given_date, room: nil)
      range_of_dates = Hotel::DateRange.get_all_dates(given_date, second_date)
      if !room.nil?
        # checks room number with 
        return @reservations.select{ |res| res.room_num == room && res.arrive == given_date}
      elsif given_date == second_date
        # Checks if the date range of any reservations includes the given_date
        return @reservations.select{ |res| range_of_dates.include?(res.arrive)}
      else
        return @reservations.select{ |res| range_of_dates.include?(res.arrive)}
      end
    end
  end
end