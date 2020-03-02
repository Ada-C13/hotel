module Hotel
  class ReservationDesk
    attr_reader :room_num

    def initialize(room_num: 20)
      @room_num = room_num
    end

    def rooms
      hotel_rooms = []
      room_num.times do |i|
        hotel_rooms << Room.new(i+1)
      end
      return hotel_rooms
    end

  end
end