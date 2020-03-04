module Hotel
  class HotelController
    # Wave 1
    def rooms
      # You might want to replace this method with an attr_reader
      return []
    end

    def reserve_room(start_date, end_date)
      # start_date and end_date should be instances of class Date
      return Reservation.new(start_date, end_date, nil)
    end

    # User: I can access the list of reservations for a specific date, so that I can track reservations by date
    def reservations(date)
      return []
    end

    # User: I access the list of reservations for a specified room and a given date range
    # User: I can access the list of all of the rooms in the hotel

    # Wave 2
    def available_rooms(start_date, end_date)
      # start_date and end_date should be instances of class Date
      return []
    end
  end
end
