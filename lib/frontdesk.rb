require 'date'

require_relative 'date.rb'
require_relative 'reservation.rb'

module Hotel
  class FrontDesk
    
    attr_reader :all_reservations, :rooms
    
    def initialize
      @all_reservations = all_reservations || []
      @rooms = [*1..20]
    end

    def assign_room(new_reservation)
      taken_rooms = []
      all_rooms = @rooms.dup
      @all_reservations.each do |reservation|
        reservation.no_conflict?(new_reservation.start_date, new_reservation.end_date) ? taken_rooms << reservation.assigned_room : next
      end
      room_to_assign = (all_rooms - taken_rooms.flatten)
      assigning = room_to_assign.sample(new_reservation.num_rooms)
      taken_rooms.include?(assigning)
        assigning = room_to_assign.sample(new_reservation.num_rooms)
    end

    def add_reservation(start_date, end_date, num_rooms)
      new_reservation = Hotel::Reservation.new(start_date: start_date, end_date: end_date, num_rooms: num_rooms)
      new_reservation.assigned_room = assign_room(new_reservation)
      if new_reservation.num_rooms > 1 
        raise ArgumentError.new("Invalid room reservation request: if you would still like #{num_rooms} rooms please reserve as a block.")
      end
      @all_reservations << new_reservation
    end

    def add_block_reservation(start_date, end_date, num_rooms, discount, block_key)
      new_reservation = Hotel::Reservation.new(start_date: start_date, end_date: end_date, num_rooms: num_rooms, discount: discount, block_key: block_key)
      new_reservation.assigned_room = assign_room(new_reservation)
      if new_reservation.num_rooms > 1 
        new_reservation.block = :BLOCK
      elsif new_reservation.num_rooms == 1
        raise ArgumentError.new("Invalid room reservation request: if you would still like #{num_rooms} room please reserve as a single.")
      end
      @all_reservations << new_reservation
    end

    def find_reservation_by_date(date)
      @all_reservations.select {|reservation| reservation.contains(date)}
    end

    def find_available_room_by_date(date)
      taken = []
      all_rooms = @rooms.dup
      booked = find_reservation_by_date(date)
      booked.map {|reservation| taken << reservation.assigned_room}
      available_rooms = (all_rooms - taken.flatten)
    end

    def find_block_by_block_key(date, block_key)
      reservations_on_day = find_reservation_by_date(date)
      in_block = reservations_on_day.select {|reservation| reservation.block_key == block_key}
      return in_block
    end

    def update_block(date, block_key)
      found_block = find_block_by_block_key(date, block_key)
      if found_block[0].num_rooms == 0
        raise ArgumentError.new("Invalid room reservation request: all rooms in this block have been reserved.")
      else
        found_block[0].num_rooms -= 1
      end
      return found_block[0]
    end
    
    # * I can reserve a specific room from a hotel block
    # * I can only reserve that room from a hotel block for the full duration of the block
    def reserve_from_block(date, block_key)
      book_room = update_block(date, block_key)
      book_room.assigned_room = book_room.assigned_room[0]
      book_room.num_rooms = 1
      return book_room
    end
  end
end