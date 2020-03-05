module Hotel
  class HotelController
    # Wave 1
    def rooms
      # You might want to replace this method with an attr_reader
      # array of hashes for rooms
      rooms = []

      room_base = []
      20.times do |i|
        room_base << ("room#{i+1}").to_sym
      end

      rooms = []
      rooms << room_base.each_with_object({}) do
          |key, h| h[key] = {:date => [], :reservation => []} 
      end

      return rooms
    end

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
