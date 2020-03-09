require_relative 'date_range'
require_relative 'reservation'
module Hotel
  class HotelController
    attr_reader :reservations, :rooms
    def initialize
      @reservations = []
      @rooms = []
      (1..20).each do |room|
        @rooms << room
      end
    end
    # Wave 1
    def rooms
      return @rooms
    end

    def reserve_room(start_date, end_date)
      if start_date.class != Date || end_date.class != Date
        raise ArgumentError.new("Please input valid dates")
      else
      reservation = Reservation.new(start_date, end_date)
      @reservations << reservation
      return reservation
    end
  end

    def reservations(date)
      reservation_list = []
      @reservations.each do |reservation|
      if reservation.include?(date)
        reservation_list << reservation
      end
    end
      return reservation_list
  end

    # # Wave 2
    def available_rooms(start_date, end_date)
      room_list = []
      range = DateRange.new(start_date, end_date)
      # start_date and end_date should be instances of class Date
      taken_rooms = reservations(range)
      room_list = @rooms - taken_rooms
     return room_list
    end
  end
end
# end