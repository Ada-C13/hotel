require "date"
require "pry"
require_relative "date_range"
require_relative "reservation"
require_relative "room"
require_relative "hotel_block"

class HotelManager < Date_Range
  attr_accessor :reservations

  def initialize
    @rooms = make_rooms
    @hotel_blocks = []
    @hotel_block_counter = 0
  end

  # - The hotel has 20 rooms, and they are numbered 1 through 20
  # - In this method we   make a rooms spanning 1 - 20
  # - Each room is placed in an array which because an room array
  def make_rooms
    room_array = []
    (1..20).each do |room_num|
      room_array << Room.new(room_num)
    end
    return room_array
  end

  # Here we check the room availability by taking in the check in and out date as parms
  # Those parms are then used to create a new Instantation of a date range
  # By setting that new instantion of a date range as a variable we can then
  # Go into each room and check that said date range
  def check_room_available?(check_in_date, check_out_date)
    date_range = Date_Range.new(check_in_date, check_out_date)
    @rooms.each do |room|
      # If no res has any overlap return true #
      if !room.check_overlap_with_room_reservations(date_range)
        return true
      end
    end
    # However if there is return false because there is a overlap. No room available whatsoever#
    return false
  end

  def find_all_resevations
    all_res = []
    @rooms.each do |room|
      room.reservations.each do |res|
        all_res << res
      end
    end
    all_res << hotel_blocks
    return all_res
  end

  def create_reservation(check_in_date, check_out_date)
    # Need to determine if which room to use for the reservation.

    # Iterate over list of rooms.
    # Find room that has availability.
    # First room that has no time conflict is the room, we choose to use for the reservation.
    # If no rooms have availability during the checkin_date to checkout_date, we should return an error/ raise an error.

    date_range = Date_Range.new(check_in_date, check_out_date)
    @rooms.each do |room|
      # If no res has any overlap return true #
      if room.check_overlap_with_room_reservations(date_range)
        room.create_new_reservation(check_in_date, check_out_date)
        return true
      end
    end

    # # Raise exception as no room is available during the requested date_range.
    raise Exception.new "There are no rooms available for this date range"
  end

  # This method is used to create a Hotel Block
  # Takes in Room Ids and check in and check out date
  # inside the method we create a method we create a variable called new requested_date_range which uses the Date_Range class
  # room_ids is the number of rooms
  # need to raise error if more than 5 rooms
  # using the make rooms we
  def create_room_block(room_ids, check_in_date, check_out_date, room_rate)
    requested_date_range = Date_Range.new(check_in_date, check_out_date)
    (1..room_ids).each do |room_id|
      room = @rooms[room_id]
      if room.check_overlap_with_room_reservations(requested_date_range)
        raise Exception.new "One of the rooms in the hotel block requested is unavailable"
      end
    end

    # Go to each room and add the reservation for the given date range
    def add_reservation (room_info)
    (1..room_ids).each do |room_id|
      room = @rooms[room_id]
      room.create_new_reservation(check_in_date, check_out_date, true)
      end
    end

    # Create the HotelBlock object and add it to the list of hotel_blocks
    hotel_blocks << Hotel_Block.new(room_ids, check_in_date, check_out_date, room_rate, @hotel_block_counter)
    @hotel_block_counter += 1
  end
end
