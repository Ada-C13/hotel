require_relative "reservation"
require_relative "room"
require_relative "block"

module Hotel
  class NoRoomError < StandardError; end

  class HotelManager
    ROOM_QTY = 20
    ROOM_NUMS = (1..20).to_a

    attr_reader :rooms, :reservations, :pending_blocks

    def initialize
      @rooms = []
      @reservations = []
      @pending_blocks = []

      ROOM_QTY.times do |i|
        @rooms << Hotel::Room.new(num: i + 1)
      end
    end


    # Wave 1
    def find_bookings_by_range(date_range)
      return @reservations.filter { |reservation| reservation.date_range.overlap?(date_range) }
    end


    def bookings_per_room(date_range, room_num)
      overlapped_reservations = find_bookings_by_range(date_range)

      found_reservations = []

      overlapped_reservations.each { |reservation|
        reservation.rooms.each { |reserved_room|
          if reserved_room.num == room_num
            found_reservations << reservation
          end
        }
      }
      return found_reservations
    end


    def find_bookings_by_date(date)
      return @reservations.find_all { |reservation|
               (reservation.date_range.include?(date)) && (reservation.rooms)
             }
    end
    

    # Wave 2
    def reserve_room(date_range)
      available_room_ids = available_room_ids(date_range)

      room = find_room_by_id(available_room_ids[0])

      # TODO
      available_room_ids.delete(available_room_ids[0])

      reservation = Reservation.new(date_range: date_range, rooms: [room])
      self.add_reservation(reservation)

      return reservation
    end


    def reserved_room_ids(date_range)
      ids = []

      reservations = find_bookings_by_range(date_range)

      reservations.each do |reservation|
        reservation.rooms.each do |room|
          ids << room.num
        end
      end
      return ids
    end


    def available_room_ids(date_range)
      reserved_room_ids = reserved_room_ids(date_range)

      available_room_ids = ROOM_NUMS - reserved_room_ids

      raise NoRoomError, "No available rooms" if available_room_ids.nil? || available_room_ids.empty?

      return available_room_ids
    end

    
    # Wave 3 (block)
    def reserve_block(date_range:, room_qty:, discount_rate: 0.8)
      available_room_ids = available_room_ids(date_range)

      block_rooms = []

      room_qty.times do |i|
        id = available_room_ids[-1]
        room = find_room_by_id(id)
        available_room_ids.delete(id) # TODO
        block_rooms << room
      end

      block = Hotel::Block.new(date_range: date_range, rooms: block_rooms)

      self.add_reservation(block)

      return block
    end


    # Helper method
    def add_reservation(reservation)
      reservations << reservation
    end

    
    def find_room_by_id(number)
      return @rooms[number - 1]
    end
  end
end
