# frozen_string_literal: true

require 'date'
require_relative 'reservation'
require_relative 'room'

class HotelDispatcher
  def initialize; end

  def make_rooms
    room_array = []
    (1..20).each do |room_num|
      room_array << Room.new(room_num)
    end
    @all_rooms = room_array
    room_array
  end

  def check_room_available?(start_date, end_date)
    nights = Date.new(end_date) - Date.new(start_date)
    nights
    # will take in a start date and end date
    # check all rooms booked dates (if date in array unavilable)
    # for each room.all loop
    # return aval room or no room aval
  end
end
