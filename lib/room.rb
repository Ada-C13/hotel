require 'date'

class Rooms
  attr_accessor :all_rooms

  def initialize
    @all_rooms = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]
  end


  def room_reserved(room_number)
    @all_rooms.delete(room_number)
  end


  def rooms
    @all_rooms
  end

end