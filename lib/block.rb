module Hotel
  class Block < Reservation
    attr_reader :id, :date_range, :rooms, :discount_rate, :available_rooms, :reserved_rooms

    def initialize(discount_rate: 0.8, **args)
      super(**args) # id, date_range, rooms

      validate_room_qty(@rooms.length)

      @discount_rate = discount_rate
      @available_rooms = @rooms
      @reserved_rooms = []
    end

    # Override an instance method from Reservation class
    def total_cost
      cost_per_room = @rooms[0].cost * @discount_rate

      total_cost = (cost_per_room * @rooms.length) * @date_range.nights

      return total_cost.to_f.round(2)
    end

    def reserve_room
      raise NoRoomError, "No room available" if @available_rooms.empty?

      reserved_rooms << available_rooms[0]
      @available_rooms.delete(available_rooms[0])

      return true
    end

    def validate_room_qty(room_qty)
      # Change test file
      if (room_qty < 2) || (room_qty > 5)
        raise ArgumentError, "A block can contain between 2 and 5 rooms (maximum of 5 rooms)"
      end
    end
  end
end
