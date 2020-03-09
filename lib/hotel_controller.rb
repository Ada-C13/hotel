module Hotel
  class HotelController 

    attr_accessor :hotel_rooms, :reservations
    attr_reader 

    def initialize()
      @hotel_rooms = (1..20).to_a
      @reservations = []
    end

    # Wave 1
    # creates a reservation of a room for a given date range
    def reserve_room(start_date, end_date, room_number, rate)
      if !available_rooms(start_date, end_date).include?(room_number)
        raise ArgumentError.new "Sorry, there is no room available on those days."
      else
        reservation = Hotel::Reservation.new(start_date, end_date, room_number, rate)
        @reservations << reservation
        return reservation
      end
    end     

    # takes a date and returns an array of reservations
    def reservations_by_date(date = Date.today)
      @reservations.select do |reservation|
        date_range = DateRange.new(reservation.start_date, reservation.end_date)
        date_range.include?(date)
      end
    end 

    # Wave 2 
   # locate available rooms by two dates and returns an array
    def available_rooms(start_date, end_date)    
      reserved_rooms = @reservations.select do |reservation|
        date_range = DateRange.new(start_date, end_date)
        date_range.overlap?(reservation.date_range)
      end.map do |reservation|
        reservation.room_number
      end
      return @hotel_rooms - reserved_rooms
    end
  end
end
