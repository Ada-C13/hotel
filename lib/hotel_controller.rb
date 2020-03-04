module Hotel
  class HotelController
    # Access the list of all of the rooms in the hotel
    attr_reader :rooms, :reservation_list
    
    # Constructor
    # Hotel has 20 rooms, numbered 1 through 20
    def initialize
      @rooms = (1..20).to_a
      @reservation_list = []
    end

    # Reserve a Room for a Given Date Range
    # Given only start and end dates, determine which room to use for the reservation
    def reserve_room(start_date, end_date)
      room = available_rooms(start_date, end_date, room).first
      reservation = Hotel::Reservation.new(start_date, end_date, room)
      @reservation_list << reservation
      return reservation
    end

    # Access the list of reservations for a specific date, so that I can track reservations by date
    def reservations(date)
      return @reservation_list.select do |reservation|
        reservation.range.include?(date)
      end
    end

    # Returns Reservation(s) Specific for Room and Range
    # Access the list of reservations for a specified room and a given date range
    def reservation_by_room(start_date, end_date, room)
      range = Hotel::DateRange.new(start_date, end_date)
      return @reservation_list.select do |reservation| # which reservations have an overlap with the ranged passed
        reservation.range.overlap?(range) && reservation.room == room
      end
    end

    # Returns Specific Room Available for a Date Range
    def room_available(start_date, end_date, room)
      return reservation_by_room(start_date, end_date, room).size == 0
    end

    # Returns List of Rooms Available for a Date Range
    # View a list of rooms that are not reserved for a given date range, so that I can see all available rooms for that date range
    def available_rooms(start_date, end_date, room)
      return @rooms.select { |room| room_available(start_date, end_date, room) }
    end

  end
end