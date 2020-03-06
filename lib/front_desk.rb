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
      date_range = Hotel::DateRange.new(start_date, end_date)
      room = find_room(date_range)
      reservation = Reservation.new(start_date, end_date, room.id)
      room.add(reservation)
      return reservation
    end

    def get_avail_rooms(start_date, end_date)
      date_range = Hotel::DateRange.new(start_date, end_date)
      avail_rooms = rooms.find_all { |room|
        room.available?(date_range)
      }
      return avail_rooms
    end

    private
    # to do: refactor
    def find_room(date_range)
      room = rooms.find {|room|
        room.reservations.length == 0
      }
      if room == nil
        room = rooms.find {|room|
          room.available?(date_range)
        }
      end
      if room == nil
        raise ArgumentError.new("No rooms are availble")
      end
      return room
    end

  end
end