require_relative "room"

module Hotel
  class HotelController
    attr_reader :rooms
    attr_accessor :reservations

    def initialize
      @rooms = Array.new(20){|i| Hotel::Room.new(i+1)}
      @reservations = []
    end

    #I can access the list of reservations for a specific date, so that I can track reservations by date
    def reserve_room(start_date, end_date)
      # start_date and end_date should be instances of class Date
      # return Reservation.new(id, start_date, end_date, room)
    end

    def reservations_for(date_range, room)
      result = []
      reservations.each do |reservation|
        if reservation.date_range.overlap?(date_range) && room.room_nr == reservation.room.room_nr
          result << reservation
        end
      end
      return result
    end

    # Wave 2
    def available_rooms(start_date, end_date)
      # start_date and end_date should be instances of class Date
      return []
    end
  end
end