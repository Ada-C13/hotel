require_relative 'reservation'
require_relative 'date_range'

module Hotel
  class HotelController
    attr_accessor :reservations, :rooms 

    def initialize(
      rooms:,
      reservations:
    )

      rooms = (1..20).map { |i| i }
      @rooms = rooms
      @reservations = reservations || []
    end




    # User: I can access the list of all of the rooms in the hotel

    # Wave 1

    def reserve_room(date_range)
      # start_date and end_date should be instances of class Date
      book_room = available_rooms(date_range).first
      new_reservation = Hotel::Reservation.new(
        room: book_room, 
        date_range: date_range,
      )
      @reservations.push(new_reservation)
      return new_reservation
    end

    # User: I can access the list of reservations for a specific date, so that I can track reservations by date
    def reservations(date)
      @reservations.each do |res|

      end
      return []
    end

    # User: I access the list of reservations for a specified room and a given date range

    # Wave 2
    def available_rooms(start_date, end_date)
      # start_date and end_date should be instances of class Date
      empty_rooms = @rooms
      return empty_rooms
    end
  end
end
