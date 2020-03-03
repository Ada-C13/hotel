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

    def find_reservations(room_id: , start_date: nil, end_date: nil)
      room = rooms.find { |room| room.id == room_id}
      return room.reservations if (start_date == nil && end_date == nil)
      #TODO: add logic here
    end


    # def find_room_by_id(id)
    #   hotel_rooms.select {|room| room.id == id}
    # end

    def new_reservation(room_id, start_date, end_date)
      raise ArgumentError.new("Invalid room ID.") unless rooms.find {|room| room.id == room_id}
      Reservation.new(room_id: room_id, start_date: start_date, end_date: end_date)
    end

    def add_reservation(new_reservation)
      reservations << new_reservation # to Room reservations?
      #new_reservation.room_id
    end


  end
end