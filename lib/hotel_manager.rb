require_relative "hotel_block"

module Hotel
  class HotelManager
    attr_reader :rooms, :blocks, :total_reservations

    def initialize
      @rooms = []
      @blocks = []
      @total_reservations = 0
    end

    def initialize_rooms(num)
      if num.class != Integer
        raise ArgumentError.new("Integer value must be provided. Value provided: '#{num}'")
      else
        num.times do |i|
          room = Hotel::Room.new((i + 1), 200)
          @rooms << room
        end
      end
    end

    def list_all_rooms
      return @rooms
    end

    def reserve_room(date_range, room = nil)
      picked_room = ""
      if !room
        available_rooms = list_available_rooms(date_range)
        raise ArgumentError.new("No rooms available") if available_rooms == []
        picked_room = available_rooms[0]
      else
        picked_room = find_room(room)
      end

        # Given a specific date, and that a room is set aside in a hotel block for that specific date, I cannot reserve that specific room for that specific date, because it is unavailable


      @total_reservations += 1
      reservation = Reservation.new(date_range, @total_reservations, picked_room.number, picked_room.cost)

      find_room(reservation.room_number).reservations << reservation
      return reservation
    end

    def reserve_block(date_range, rooms, discount_rate)
      check_availability = check_block_availability(date_range, rooms)

      add_block_rooms(date_range, check_availability, discount_rate)

      block = Hotel::HotelBlock.new(date_range, check_availability, discount_rate, @blocks.length + 1)
      @blocks << block

      return block
    end

    def add_block_rooms(date_range, rooms, discount_rate)
      rooms.each do |room|
        @total_reservations += 1
        reservation = Hotel::Reservation.new(date_range, @total_reservations, room.number, room.cost * (1 + discount_rate), @blocks.length + 1, true)
        room.reservations << reservation
      end
    end

    def check_block_availability(date_range, rooms)
      available_rooms = list_available_rooms(date_range)

      raise ArgumentError.new("Not all rooms have availability") if !(rooms - available_rooms).empty?

      return rooms
    end

    def create_block_reservation(date_range, room, discount_rate, block)
      @total_reservations += 1
      reservation = Hotel::Reservation.new(date_range, @total_reservations, room.number, room.cost, discount_rate, @blocks.length + 1)
      return reservation
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

    def list_available_rooms(date_range)
      available_rooms = []

      @rooms.length.times do |i|
        room = find_room(i + 1)
        available = room.check_availability(date_range)
        available_rooms << room if available
      end

      return available_rooms
    end

  end
end