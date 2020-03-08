require "date"
require_relative "date_range"
require_relative "reservation"
require_relative "room"

class HotelManager < Date_Range
  attr_accessor :reservations

  def initialize
    @rooms = make_rooms
    @hotel_blocks = []
    @hotel_block_counter = 0
  end

  # - The hotel has 20 rooms, and they are numbered 1 through 20
  def make_rooms
    room_array = []
    (1..20).each do |room_num|
      room_array << Room.new(room_num)
    end
    return room_array
  end

  # - When reserving a room, the user provides only the start and end dates - the library should determine which room to use for the reservation

  # check all rooms booked dates (if date in array unavilable)
  # for each room.all loop
  # return aval room or no room aval
  # - When reserving a room, the user provides only the start and end dates - the library should determine which room to use for the reservation
  # - I can view a list of rooms that are not reserved for a given date range, so that I can see all available rooms for that day
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
    return all_res
    # reservation_array = Reservation.all
    # reservation_array.each do |reservation|
    #   return reservation if reservation.room_num == @room_num
  end

  def create_reservation(check_in_date, check_out_date)
    # Need to determine if which room to use for the reservation.

    # Iterate over list of rooms.
    # Find room that has availability.
    # First room that has not time conflict is the room, we choose to use for the reservation.
    # If no rooms have availability during the checkin_date to checkout_date, we should return an error/ raise an error.

    date_range = Date_Range.new(check_in_date, check_out_date)
    @rooms.each do |room|
      # If no res has any overlap return true #
      if !room.check_overlap_with_room_reservations(date_range)
        room.create_new_reservation(check_in_date, check_out_date)
        return
      end
    end

    # Raise exception as no room is available during the requested date_range.
    raise Exception.new "There are no rooms available for this date range"
  end

  def create_room_block(room_ids, check_in_date, check_out_date, room_rate)
    requested_date_range = Date_Range.new(check_in_date, check_out_date)
    room_ids.each do |room_id|
      room = @rooms[room_id]
      if room.check_overlap_with_room_reservations(requested_date_range)
        raise Exception.new "One of the rooms in the hotel block requested is unavailable"
      end
    end

    # Go to each room and add the reservation for the given date range
    room_ids.each do |room_id|
      room = @rooms[room_id]
      room.create_new_reservation(check_in_date, check_out_date, true)
    end

    # Create the HotelBlock object and add it to the list of hotel_blocks
    hotel_blocks << HotelBlock.new(room_ids, check_in_date, check_out_date, room_rate, @hotel_block_counter)
    @hotel_block_counter += 1
  end
end

# - For this wave, any room can be reserved at any time, and you don't need to check whether reservations conflict with each other (this will come in wave 2!)
