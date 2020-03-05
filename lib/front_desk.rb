require_relative 'room'
module Hotel
  class FrontDesk 
    attr_reader :rooms, :reservations
    def initialize
        @rooms = []
        (1..20).each do |n|
          @rooms << Room.new(n)
        end
        # fill @rooms with rooms 1-20, consecutively
    end

    def reserve_room(start_date, end_date)
      room = find_room
      reservation = Reservation.new(start_date, end_date, room.id)
      room.add(reservation)
      return reservation
    end

    private
    # to do: refactor
    def find_room
      room = rooms.find {|room|
        room.reservations.length == 0
      }
      if room == nil
        room = rooms.find {|room|
          room.available?
        }
      end
      if room == nil
        raise ArgumentError.new("No rooms are availble")
      end
      return room
    end

  end
end