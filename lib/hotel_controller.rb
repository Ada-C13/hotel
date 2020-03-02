module Hotel
  class HotelController

    def self.reserve_room(start_date, end_date)
      return Reservation.new(start_date, end_date)
    end

  end
end