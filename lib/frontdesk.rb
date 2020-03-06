require 'date'

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
      all_rooms = @rooms
      @all_reservations.each do |reservation|
        reservation.conflict?(new_reservation.start_date, new_reservation.end_date) ? taken_rooms << reservation.assigned_room : next
      end
      room_to_assign = (all_rooms - taken_rooms.flatten)
      return room_to_assign.sample(1)
    end

    def add_reservation(start_date, end_date, num_rooms)
      new_reservation = Hotel::Reservation.new(start_date: start_date, end_date: end_date, num_rooms: num_rooms)
      new_reservation.assigned_room = assign_room(new_reservation)
      if new_reservation.num_rooms > 1 
        new_reservation.block = :BLOCK 
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

    def reserve_from_block(date, block_key)
      reservations_on_day = find_reservation_by_date(date)
      in_block = reservations_on_day.select {|reservation| reservation.block_key == block_key}
      return in_block
      p in_block
    end
  end
end