require_relative "room"

module Hotel
  class HotelController
    attr_reader :rooms
    def initialize
      @rooms = Array.new(20){|i| Hotel::Room.new(i+1)}
    end


    def reserve_room(start_date, end_date)
      # start_date and end_date should be instances of class Date
      return Reservation.new(start_date, end_date, nil)
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