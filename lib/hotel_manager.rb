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
      return Reservation.new(
        date_range, 
        id = @total_reservations, 
        room_number = rand(1..20),
        total_cost = calculate_cost(date_range, room_number)
      )
    end

    def calculate_cost(date_range, room)
      return date_range.total_nights * find_room(room).cost
    end

    def find_room(id)
      found_room = @rooms.find { |room| room.number == id }
      return found_room
    end

    def list_reservations_by_room(room, date_range)
      reservation_list = []
      found_room = find_room(room)
      
      found_room.reservations.each do |reservation|
        if reservation.date_range.overlap?(date_range) == true
          reservation_list << reservation
        end
      end

      return reservation_list
    end

    def list_reservations_by_date(date)
      reservation_list = []

      @rooms.each do |room|
        room.reservations.each do |reservation|
          if reservation.date_range.range.include?(date)
            reservation_list << reservation
          end
        end
      end

      return reservation_list
    end

  end
end