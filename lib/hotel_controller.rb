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

    # On reservation list, for each reservation, check if the range include the date in question 
    def reservations(date)
      return @reservation_list.select do |reservation|
        reservation.range.include?(date)
      end
    end

    # Reservations for a Given Room and Range room 2, jan 1st - jan 30
    def reservation_by_room(start_date, end_date, room)
      range = Hotel::DateRange.new(start_date, end_date)
      return @reservation_list.select do |reservation| # which reservations have an overlap with the ranged passed
        reservation.range.overlap?(range) && reservation.room == room
      end
    end


    # def reservation_by_date(start_date, end_date)

    # end


    # Wave 2
    def available_rooms(start_date, end_date, room) # return the list of rooms available in this date range
      return @rooms.select { |room| room_available(start_date, end_date, room)}
    end

    def room_available(start_date, end_date, room) # return true if one room is available for this range
      return reservation_by_room(start_date, end_date, room).size == 0
    end


  end
end