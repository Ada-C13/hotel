module Hotel
  class HotelController
    attr_reader :rooms, :reservation_list
    
    # Constructor
    def initialize
      @rooms = (1..20).to_a
      @reservation_list = []
    end

    # Access List of All Rooms in the Hotel
    def reserve_room(start_date, end_date)
      room = available_rooms(start_date, end_date, room).first
      reservation = Hotel::Reservation.new(start_date, end_date, room)
      @reservation_list << reservation
      return reservation
    end

    # On Reservation List for each Reservation Check if Range Includes Date in Question 
    def reservations(date)
      return @reservation_list.select do |reservation|
        reservation.range.include?(date)
      end
    end

    # Returns Reservation(s) for Speciifc Room and Range
    def reservation_by_room(start_date, end_date, room)
      range = Hotel::DateRange.new(start_date, end_date)
      return @reservation_list.select do |reservation| # which reservations have an overlap with the ranged passed
        reservation.range.overlap?(range) && reservation.room == room
      end
    end

    # Return Specific Room is Available for a Date Range
    def room_available(start_date, end_date, room)
      return reservation_by_room(start_date, end_date, room).size == 0
    end

    # Return the List of Rooms Available for a Date Range
    def available_rooms(start_date, end_date, room)
      return @rooms.select { |room| room_available(start_date, end_date, room) }
    end

    # def reservation_by_date(start_date, end_date)
    # end
    # Wave 2
  end
end