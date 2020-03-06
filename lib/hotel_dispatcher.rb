require "date"
require_relative "date_range"
require_relative "reservation"
require_relative "room"

class HotelManager < Date_Range
  attr_accessor :reservations

  def initialize
    @rooms = make_rooms
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
      if !room.reservations.any? { |res| res.overlaps_in_reservations?(new_date_range) }
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
end

# - For this wave, any room can be reserved at any time, and you don't need to check whether reservations conflict with each other (this will come in wave 2!)
