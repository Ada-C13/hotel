require_relative 'reservation'
require_relative 'date_range'

module Hotel
  class FrontDesk
    attr_accessor :reservations, :rooms, :calendar

    def initialize
      @rooms = (1..20).map { |i| i }
      @reservations = []
      @calendar = {}
    end

    def populate_calendar(reservation)
      reservation.date_range.dates.each do |date|
        if !@calendar.key?(date)
          @calendar[date] =[]
        end
        @calendar[date] << reservation
      end
      return @calendar
    end


    # User: I can access the list of all of the rooms in the hotel
    def list_rooms
      return @rooms
    end

    # Wave 1

    def reserve_room(requested_dates)
       # empty_rooms = available_rooms(requested_dates)
       available_rooms = @rooms # wave 1
       book_room = available_rooms.first
       new_reservation = Hotel::Reservation.new(
        room: book_room, 
        date_range: requested_dates,
      )
      @reservations.push(new_reservation)
      # populate_calendar(new_reservation)
      return new_reservation
    end

    # User: I can access the list of reservations for a specific date, so that I can track reservations by date
    def date_reservations(date)
      @reservations.each do |res|
        res.select if @reservation.includes? Date
      end
      return []
    end

    # User: I access the list of reservations for a specified room and a given date range

    # Wave 2
    def available_rooms(requested_dates)
      # start_date and end_date should be instances of class Date
      # empty_rooms = @rooms.reject do |room|
      #   @reservations.any?{ |reservation| reservation.requested_dates.overlap?(requested_dates) == true }
      # end
      return rooms
    end
  end
end
