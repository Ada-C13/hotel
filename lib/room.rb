require 'date'

class Rooms

  def initialize 
    @available_rooms = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]
  end

  def room_reserved(room_number)
    @available_rooms.delete(room_number)
  end

  def rooms
    @available_rooms
  end

end