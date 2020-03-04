require 'date'

require_relative 'reservation.rb'
require_relative 'date_range.rb'
require_relative 'room.rb'

module Hotel
  class HotelController
    attr_reader :rooms, :reservations

    def initialize
      rooms_array = []
      20.times{ |i| rooms_array.push(Hotel::Room.new(i+1)) }
      @rooms = rooms_array
      @reservations = []
    end

    def list_rooms
      return @rooms
    end
    
    def rooms
      # You might want to replace this method with an attr_reader
      return []
    end

    def reserve_room(start_date, end_date)
      # start_date and end_date should be instances of class Date
      new_reservation = Reservation.new(start_date, end_date, nil)
      @reservations.push(new_reservation)
      return new_reservation
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