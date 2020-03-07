require "date"
require_relative "reservation"
require_relative "date_range"

module Hotel
  class HotelController
    attr_reader :rooms, :reservations, :blocks

    def initialize(rooms: (1..20).to_a, reservations: [])
      @rooms = rooms
      @reservations = reservations
      @blocks = []
    end

    def make_reservation(check_in, check_out)
      date_range = DateRange.new(check_in: check_in, check_out: check_out)
      if @reservations.length > 0
        room = find_available_rooms(check_in, check_out).first
      else
        room = @rooms.first
      end
      reservation = Reservation.new(date_range: date_range, room: room)
      @reservations << reservation
      return reservation
    end

    def make_block(check_in, check_out, rooms, discounted_rate)
      date_range = DateRange.new(check_in: check_in, check_out: check_out)
      block = Block.new(date_range: date_range, rooms: rooms, discounted_rate: discounted_rate)
      @blocks << block
      return block
    end

    def find_available_rooms(check_in, check_out)
      new_date_range = DateRange.new(check_in: check_in, check_out: check_out)
      available_rooms = @rooms.clone
      @reservations.each do |reservation|
        if reservation.date_range.overlap?(new_date_range) == true
          available_rooms.delete(reservation.room)
        end
      end

      @blocks.each do |block|
        if block.date_range.overlap?(new_date_range) == true
          block.rooms.each do |room|
            available_rooms.delete(room)
          end
        end
      end

      if available_rooms.length > 0
        return available_rooms
      else
        raise StandardError, "There are no rooms available for those days"
      end
    end

    def find_by_date(date) # add blocks
      all_reservations_for_date = []
      @reservations.each do |reservation|
        if reservation.date_range.include?(date) == true
          all_reservations_for_date << reservation
        end
      end
      return all_reservations_for_date
    end

    def find_by_date_and_room(room, date) # add blocks
      all_reservations_for_date_and_room = []
      @reservations.each do |reservation|
        if reservation.date_range.include?(date) && reservation.room == room
          all_reservations_for_date_and_room << reservation
        end
      end
    end

    def show_all_rooms
      return @rooms
    end

    # Do I need this method here?
    def show_reservation_cost(reservation) # add blocks?
      return reservation.calculate_cost
    end
  end
end

# Wave 3: Hotel Blocks

# A Hotel Block is a group of rooms set aside for a specific group of customers for a set period of time.
# Hotel Blocks are commonly created for large events like weddings or conventions. They contain a number of rooms and a specific set of days. These rooms are set aside, and are made available for reservation by certain customers at a discounted rate. These rooms are not available to be reserved by the general public.

# I want an exception raised if I try to create a Hotel Block and at least one of the rooms is unavailable for the given date range
# Given a specific date, and that a room is set aside in a hotel block for that specific date, I cannot reserve that specific room for that specific date, because it is unavailable
# Given a specific date, and that a room is set aside in a hotel block for that specific date, I cannot create another hotel block that includes that specific room for that specific date, because it is unavailable

# I can check whether a given block has any rooms available

# I can reserve a specific room from a hotel block

# I can only reserve that room from a hotel block for the full duration of the block
# I can see a reservation made from a hotel block from the list of reservations for that date (see wave 1 requirements)

# When a room is reserved from a block of rooms, the reservation dates will always match the date range of the block
# All of the availability checking logic from Wave 2 should now respect room blocks as well as individual reservations

# Feedback reqs:
# creates a block of rooms
# reserves a room from a block
