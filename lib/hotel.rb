require 'awesome_print'
require_relative 'reservation'
require_relative 'room'

module Hotel
  class Room
  
  attr_reader :id, :rooms, :reservations
    def initialize(id, rooms, reservations)
      @id = id
      @rooms = rooms
      @reservations = reservations
    end
  end

end

#**************************************
#Methods

def reserve_room(reservation)
  
end

def find_room(room_number)
  
end
