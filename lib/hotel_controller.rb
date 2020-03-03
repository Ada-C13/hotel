module Hotel
  class HotelController
    # Wave 1
    def rooms 
      rooms = [1..20]
      return rooms    # You might want to replace this method with an attr_reader
    end

    # need a defination that is an access list of all rooms in the hotel

    def reserve_room(start_date, end_date)
      # start_date and end_date should be instances of class Date
      return Reservation.new(start_date, end_date, nil)
    end

    def reservations(date)
      return []
    end

    # Wave 2
    def available_rooms(start_date, end_date)  
      # start_date and end_date should be instances of class Date
      return []
    end
  end
end
