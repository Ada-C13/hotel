module Stayappy
  class ReservationManager
    
    attr_reader :rooms, :bookings 
    
    STANDARD_ROOM_COST = 200

    def initialize
      @rooms = []
      1..20.times do |room_num|
        @rooms << Room.new(room_num: room_num, cost: STANDARD_ROOM_COST)
      end
      @bookings = []
    end

    def assign_room(check_in, check_out)
      available_rooms = @rooms.clone
      # Loop through all the bookings to see which rooms are taken
      @bookings.each do |res|
        if res.stay_overlaps?(other_check_in: check_in, other_check_out: check_out)
          available_rooms.delete(res.room)
          if available_rooms.length == 0
            raise ArgumentError.new("No rooms available for reservation window #{check_in} to #{check_out}")
          end
        end
      end
      available_rooms[0]
    end

    def make_reservation(check_in, check_out)
      room = assign_room(check_in, check_out)
      res = Reservation.new(
        check_in: check_in,
        check_out: check_out,
        room: room
      )
      @bookings << res
      res
    end

    # TODO: write these tests
    def reservations_by_room(room, start_date, end_date)
      matching_reservations = []
      @bookings.each do |res|
        if (reservation.in_range?(start_date, end_date) && reservation.room == room)
            matching_reservations << reservation
        end
      end
    end

    def reservations_by_date(date)

    end
  end
end

