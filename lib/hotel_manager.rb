module Hotel
  class HotelManager
    attr_reader :rooms, :total_reservations

    def initialize
      @rooms = []
      @total_reservations = 0
    end

    def initialize_rooms(num)
      if num.class != Integer
        raise ArgumentError.new("Integer value must be provided. Value provided: '#{num}'")
      else
        num.times do |i|
          room = Hotel::Room.new((i + 1), 200)
          @rooms.push(room)
        end
      end
    end

    def list_rooms
      return @rooms
    end

    def reserve_room(daterange)
      @total_reservations += 1
      return Reservation.new(daterange)
    end
  end
end