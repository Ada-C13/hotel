module Hotel
  class HotelController
    attr_reader :rooms, :reservation_list
    
    def initialize
      @rooms = (1..20).to_a
      @reservation_list = []
    end

    def reserve_room(start_date, end_date)
      room = available_rooms(start_date, end_date).first
      reservation = Hotel::Reservation.new(start_date, end_date, room)
      @reservation_list << reservation
      return reservation
    end

    # on reservation list, for each reservation, check if the range include the date in question 
    def reservations(date)
      return @reservation_list.select do |reservation|
        reservation.range.include?(date)
      end
    end

    # Wave 2
    def available_rooms(start_date, end_date)
      # start_date and end_date should be instances of class Date
      return []
    end
  end
end
