require_relative 'room'
require_relative 'reservation'
require_relative 'date_range'

module Hotel
  class FrontDesk
    attr_reader :rooms, :reservations

    def initialize
      @rooms = []
      20.times do |i|
        @rooms << Room.new(i+1)
      end
      @reservations = []
    end

    def add_reservation(reservation)
      @reservations << reservation
    end

    def get_bookings(date)
      check_date = Date.parse(date)
      return @reservations.find_all{ |reservation| 
      reservation.date_range.includes?(date)}
    end

    def get_range_bookings(range)
      return @reservations.find_all{ |reservation| 
        reservation.date_range.overlap?(range)}
    end

    def get_room_bookings(number, range)
      range_bookings = get_range_bookings(range)
      return range_bookings.find_all{ |reservation| reservation.rooms.number == number }
    end

    def get_reserved_rooms(range)
      range_bookings = get_range_bookings(range)
      reserved_rooms = range_bookings.map do |reservation|
        reservation.rooms
      end
      return reserved_rooms
    end

    def get_available_rooms(range)
      reserved_rooms = get_reserved_rooms(range)
      available_rooms = @rooms - reserved_rooms
      return available_rooms
    end

    def reserve_room(range)
      available_rooms = get_available_rooms(range)
      raise ArgumentError, "No available rooms for this date range" if available_rooms.empty?
      new_reservation = Reservation.new(rooms: available_rooms.first, date_range: range)
      add_reservation(new_reservation)
      return new_reservation
    end

    def reserve_block(range, rooms_count, discounted_rate)
      available_rooms = get_available_rooms(range)
      raise ArgumentError, "No available rooms for this date range" if available_rooms.empty?
      raise ArgumentError, "Not enough rooms available" if available_rooms.size < rooms_count
      rooms = available_rooms[0..rooms_count]
      new_block = HotelBlock.new(rooms: rooms, date_range: range, discounted_rate: discounted_rate)
      add_block_to_reservations(new_block)
      return new_block
    end

    def add_block_to_reservations(block)
      (block.rooms.length - 1).times do |i|
        @reservations << Reservation.new(rooms: block.rooms[i], date_range: block.date_range)
      end
    end
  end
end
