require 'securerandom'

module Hotel
  class FrontDesk
    attr_reader :rooms, :reservations, :blocks

    def initialize()
      @rooms = Array.new(20) { |room| room + 1 }
      @reservations = []
      @blocks = {}
    end

    def available_rooms_for(date_range)
      reserved_rooms = @reservations
        .filter { |reservation| reservation.date_range.overlap?(date_range) }
        .map { |reservation| reservation.room }

      rooms_in_blocks = @blocks
        .filter { |id, block| block.date_range.overlap?(date_range) }
        .flat_map { |id, block| block.room_collection }

      available_rooms = @rooms
        .filter { |room| !reserved_rooms.include?(room) }
        .filter { |room| !rooms_in_blocks.include?(room) }

      return available_rooms
    end

    def make_reservation(start_date, end_date)
      date_range = Hotel::DateRange.new(start_date, end_date)

      available_rooms = available_rooms_for(date_range)

      if available_rooms.empty?
        raise ArgumentError.new("No available rooms!")
      end

      to_be_reserved = available_rooms[0]

      puts "Room=#{to_be_reserved} is going to be reserved for startDate=#{start_date}, endDate=#{end_date}"

      @reservations << Hotel::Reservation.new(date_range, to_be_reserved)
    end

    def reservations_by_room(room)
      if !room.is_a? Integer
        raise ArgumentError.new("Invalid argument #{rooms}. Should be of type Integer.")
      end

      return @reservations.select { |reservation| reservation.room == room }
    end

    def reservations_by_start_date(date)
      if !date.is_a? Date
        raise ArgumentError.new("Invalid argument #{date}. Should be of type Date.")
      end

      @reservations.select { |reservation|
        reservation.date_range.start_date == date
      }
    end

    def reservations_by_date_range(start_date, end_date)
      @reservations.select { |reservation|
        reservation.date_range.equals?(to_date_range(start_date, end_date))
      }
    end

    def reservations_by_room_and_date_range(start_date, end_date, room)
      @reservations.select { |reservation|
        reservation.date_range.equals?(to_date_range(start_date, end_date)) &&
        reservation.room == room
      }
    end

    def make_block(date_range, number_of_rooms, discount_rate)
      room_collection = get_rooms_for_block(date_range, number_of_rooms)
      id = generate_block_id

      @blocks[id] = Hotel::Block.new(date_range, room_collection, discount_rate)
    
      return id
    end

    def create_reservation_for_block(block_id, room)
      if !@blocks.has_key?(block_id)
        raise ArgumentError.new("Block is not found.")
      end

      block = @blocks[block_id]
      
      if !block.room_collection.include?(room)
        raise ArgumentError.new("No room found in block.")
      end

      if @reservations.find { |reservation| reservation.room == room }
        raise ArgumentError.new("Room #{room} already reserved")
      end

      @reservations << Hotel::Reservation.new(block.date_range, room)
    end

    private

    def to_date_range(start_date, end_date)
      return Hotel::DateRange.new(start_date, end_date)
    end

    def generate_block_id
      return SecureRandom.uuid
    end

    def get_rooms_for_block(date_range, number_of_rooms)
      if number_of_rooms > 5 || number_of_rooms < 1
        raise ArgumentError.new("Invalid number of rooms #{number_of_rooms}. Min is 1. Max is 5.")
      end

      available_rooms = available_rooms_for(date_range)

      if number_of_rooms > available_rooms.length
        raise ArgumentError.new("Not enough available rooms for the block reservation.")
      end

      return available_rooms.slice(0, number_of_rooms)
    end
  end
end
