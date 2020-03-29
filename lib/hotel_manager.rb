require_relative "reservation"
require_relative "room"
require_relative "block"
require "csv"

module Hotel
  class NoRoomError < StandardError; end

  class HotelManager
    ROOM_NUMS = (1..20).to_a

    attr_reader :rooms, :reservations

    def initialize
      @rooms = []
      @reservations = []

      load_rooms_from_csv

      # TODO
      # load_reservations_from_csv
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


      # TODO (CSV)
      reservation_hash = {
        :id => reservation.id,
        :start_date => reservation.date_range.start_date, 
        :end_date => reservation.date_range.end_date, 
        :room_qty => reservation.rooms.length,
        :cost => reservation.total_cost
      }

      write_reservations_to_csv(reservation_hash) 

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

      raise NoRoomError, "No available rooms" if available_room_ids.empty?

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
      @reservations << reservation
    end

    def find_room_by_id(number)
      return @rooms[number.to_i - 1]
    end


    # private
    def load_rooms_from_csv
      CSV.read("test/test_data/room.csv", headers: true, header_converters: :symbol).each do |record|
        @rooms << Hotel::Room.new(
          num: record[:num].to_i,
          cost: record[:cost].to_f.round(2),
        )
      end
    end


    def write_reservations_to_csv(reservation_hash) 
      reservation_csv = CSV.open("test/test_data/reservation.csv", "a+",
        write_headers: true,
        headers: [:id, :start_date, :end_date, :room_qty, :cost])

      reservation_csv << reservation_hash
    end 


    # TODO
    # def load_reservations_from_csv
    #   CSV.read("test/test_data/reservation.csv", headers: true, header_converters: :symbol).each do |record|
    #     date_range = Hotel::DateRange.new(Date.strptime(record[:start_date], "%Y-%m-%d"), Date.strptime(record[:end_date]))

    #     reserve_room(date_range)
    #   end

      # CSV.read("test/test_data/block.csv", headers: true, header_converters: :symbol).each do |record|
      #   size = record[:room_qty].to_i

      #   size.times do
      #     date_range = Hotel::DateRange.new(Date.strptime(record[:start_date], '%Y-%m-%d'), Date.strptime(record[:end_date]))

      #     reserve_block(date_range: date_range, room_qty: record[:room_qty].to_i, discount_rate: record[:discount_rate].to_f.round(2))
      #   end
      # end
    # end
  end
end
