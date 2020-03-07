module Hotel
  class Block < DateRange
    attr_reader :reservations, :rate
    def initialize(start_date, end_date, rooms, rate)
      if rooms.length > 5
        raise ArgumentError.new("Blocks can only be made for 5 rooms or less.")
      end
      super(start_date, end_date)
      range = DateRange.new(start_date, end_date)
      if rooms.any? { |room| !(room.available?(range))}
        raise ArgumentError.new("One or more of the rooms is not available at given date range.")
      end
      @rate = rate
      @reservations = []
      @available_rooms = rooms
      @available_rooms.each do |room|
        room.add(self)
      end
    end

    def reserve(room)
      if !(@available_rooms.include?(room))
        raise ArgumentError.new("Room #{room.id} is not in this Block.")
      end
      if @available_rooms.all?{|r| r == nil}
        raise ArgumentError.new("All rooms in block are already reserved.")
      end
      new_res = Reservation.new(start_date, end_date, room.id, rate)
      self.reservations << new_res

      # finds the block in room's reservations, turns it into a reservation
      i = room.reservations.find_index {|reservation|
        reservation.nights == self.nights
      }
      room.reservations[i] = new_res
      j = @available_rooms.find_index {|r|
        r == room
      }
      @available_rooms[j] = nil
    end

    def available_rooms
      return @available_rooms.find_all {|room| room != nil}
    end

  end
end