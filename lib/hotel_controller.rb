module Hotel
  class HotelController

    def self.reserve_room(start_date, end_date)
      raise ArgumentError, "End date must be after start date" if end_date < start_date || end_date == start_date
      return Reservation.new(start_date, end_date)
    end

    def self.list_reservations(start_date, end_date = start_date, room = nil)
      
    end
  end
end