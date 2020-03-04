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

    def list_all_rooms
      return @rooms
    end

    def reserve_room(date_range)
      @total_reservations += 1
      return Reservation.new(date_range)
    end

    def find_room(id)
      return @rooms.find { |room| room.number == id }
    end

    def list_reservations_by_room(room, date_range)
      reservation_list = []
      found_room = find_room(room)
      
      found_room.reservations.each do |reservation|
        if reservation.date_range.overlap?(date_range) == true
          reservation_list.push(reservation)
        end
      end

      return reservation_list
    end

    def list_reservations_by_date(date)
      reservation_list = []

      @rooms.each do |room|
        room.reservations.each do |reservation|
          if reservation.date_range.range.include?(date)
            reservation_list.push(reservation)
          end
        end
      end

      return reservation_list
    end

  end
end