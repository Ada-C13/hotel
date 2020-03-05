require_relative 'reservation'
require_relative 'date_range'

module Hotel
  class HotelController
    attr_accessor :reservations, :rooms 

    def initialize(
      rooms:,
      reservations:
    )

      
      @rooms = rooms
      @reservations = reservations || []
    end

    def all_rooms
      rooms = (1..20).map { |i| i }
      return rooms
    end


    # User: I can access the list of all of the rooms in the hotel

    # Wave 1

    def reserve_room(start_date, end_date)
      # start_date and end_date should be instances of class Date
      book_room = available_rooms(start_date, end_date).first
      new_reservation = Reservation.new(
        start_date: start_date, 
        end_date: end_date, 
        room: book_room,
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
