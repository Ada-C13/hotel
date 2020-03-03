module Hotel
  class ReservationDesk
    attr_reader :room_num, :reservations

    def initialize(room_num: 20)
      @room_num = room_num
      @reservations = []
    end

    def rooms
      hotel_rooms = []
      room_num.times do |i|
        hotel_rooms << Room.new(i+1)
      end
      return hotel_rooms
    end

    def new_reservation(start_date, end_date)
      Reservation.new(start_date: start_date, end_date: end_date)
    end

    def add_reservation(new_reservation)
      reservations << new_reservation
    end


  end
end