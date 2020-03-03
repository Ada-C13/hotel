module Hotel
  class ReservationDesk
    attr_reader :room_num, :rooms, :reservations

    def initialize(room_num: 20)
      @room_num = room_num
      @rooms = make_rooms
      @reservations = [] 
      #TODO: not needed?
    end

    def find_room_by_id(id)
      rooms.find {|room| room.id == id}
    end

    def find_reservations(room_id: , start_date: nil, end_date: nil)
      room = rooms.find { |room| room.id == room_id}
      return room.reservations if (start_date == nil && end_date == nil)
      #TODO: add logic here
    end

    def new_reservation(room_id: , start_date: , end_date: )
      raise ArgumentError.new("Invalid room ID.") unless rooms.find {|room| room.id == room_id}
      Reservation.new(room_id: room_id, start_date: start_date, end_date: end_date)
    end

    def add_reservation(new_reservation)
      room = find_room_by_id(new_reservation.room_id)
      room.reservations << new_reservation
    end

    private
    def make_rooms
      rooms = []
      room_num.times do |i|
        rooms << Room.new(i+1)
      end
      return rooms
    end

  end
end