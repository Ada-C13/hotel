require 'date'
require_relative 'reservation'
require_relative 'room'

class HotelDispatcher
  def initialize; end

# - For this wave, any room can be reserved at any time, and you don't need to check whether reservations conflict with each other (this will come in wave 2!)

# - The hotel has 20 rooms, and they are numbered 1 through 20
  def make_rooms
    room_array = []
    (1..20).each do |room_num|
      room_array << Room.new(room_num)
    end
    @all_rooms = room_array
    room_array
  end

# - When reserving a room, the user provides only the start and end dates - the library should determine which room to use for the reservation

  def check_room_available?(start_date,end_date)
    start_date = Date.parse(start_date)
    end_date= Date.parse(end_date)
    p end_date
    # will take in a start date and end date
    # check all rooms booked dates (if date in array unavilable)
    # for each room.all loop
    # return aval room or no room aval
  end
end
