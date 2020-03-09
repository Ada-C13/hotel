module Stayappy
  class ReservationManager
    
    attr_reader :rooms, :bookings, :block_reservations 
    
    STANDARD_ROOM_COST = 200

    def initialize
      @rooms = []
      20.times do |room_num|
        @rooms << Room.new(room_num: room_num + 1, cost: STANDARD_ROOM_COST)
      end
      @bookings = []
      @block_reservations = []
    end

    def assign_room(check_in, check_out)
      available_rooms = view_by_vacancy(check_in, check_out)
      if available_rooms.length == 0
        raise ArgumentError.new("No rooms available for reservation window #{check_in} to #{check_out}")
      end
      available_rooms[0]
    end

    def make_reservation(check_in, check_out)
      room = assign_room(check_in, check_out)
      reservation = Reservation.new(room, check_in, check_out)
      @bookings << reservation
      reservation
    end

    def reservations_by_room(room_num, start_date, end_date)
      matching_reservations = []
      @bookings.each do |reservation|
        puts reservation.room.room_num
        if (reservation.in_range?(start_date, end_date) && reservation.room.room_num == room_num)
            matching_reservations << reservation
        end
      end
      matching_reservations
    end

    def reservations_by_date(date)
      matching_reservations = []
      @bookings.each do |reservation|
        puts reservation.room.room_num
        if reservation.in_range?(date, date)
            matching_reservations << reservation
        end
      end
      matching_reservations
    end

    def view_by_vacancy(check_in, check_out)
      available_rooms = @rooms.clone
      # Loop through all the bookings to see which rooms are taken
      @bookings.each do |reservation|
        if reservation.in_range?(check_in, check_out)
          available_rooms.delete(reservation.room)
          if available_rooms.length == 0
            return []
          end
        end
      end
      @block_reservations.each do |reservation|
        if reservation.in_range?(check_in, check_out)
          reservation.block.each do |room|
            available_rooms.delete(room)
          end
          if available_rooms.length == 0
            return []
          end
        end
      end
      available_rooms
    end

    def get_block(room_nums)
      block_rooms = []
      room_nums.each do |room_num|
        if room_num < 0 || room_num >= @rooms.length
          raise ArgumentError.new("Invalid room number.")
        end
        block_rooms << @rooms[room_num -1]
      end
      block_rooms
    end

    def make_block(room_nums, check_in, check_out, discounted_rate)
      block_rooms = get_block(room_nums)
      @block_reservations.each do |block|
        if !block.in_range?(check_in, check_out)
          next
        end 
        if (block.block & block_rooms).length > 0
          raise ArgumentError.new("At least one room is not available in the block.")
        end 
      end 

      @bookings.each do |reservation|
        if !reservation.in_range?(check_in, check_out)
          next
        end
        if block_rooms.include?(reservation.room)
          raise ArgumentError.new("That room is not available.")
        end
      end
      block_reservation = BlockRes.new(block_rooms, check_in, check_out, discounted_rate)
      @block_reservations << block_reservation
      block_reservation
    end
  end
end
