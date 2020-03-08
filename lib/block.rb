module Hotel
  class Block
    attr_reader :date_range, :room_collection, :discount_rate

    def initialize(date_range, room_collection, discount_rate)
      @date_range = date_range
      
      validate_input(date_range, room_collection, discount_rate)

      @room_collection = room_collection
      @discount_rate = discount_rate
    end

    def calculate_cost
      cost = (@date_range.nights) * 200
      return cost - (cost * (@discount_rate/100.0))
    end

    private

    def validate_input(date_range, room_collection, discount_rate)
      if !room_collection.is_a? Array
        raise ArgumentError.new("Invalid argument #{room_collection}. Must be of type Array")
      end

      if room_collection.length > 5
        raise ArgumentError.new("Room collection cannot have more than 5 rooms in it.")
      end

      room_collection.each do |room|
        if !room.is_a? Integer
          raise ArgumentError.new("Invalid argument #{room}. Must be a type of Integer.")
        end
      end

      invalid_rooms = []
      
      room_collection.each do |room|
        if (room < 1) || (room > 20)
          raise ArgumentError.new("Invalid room number(s). Room number cannot be less than 0 and greater than 20.")
        end
      end

      if !discount_rate.is_a? Integer
        raise ArgumentError.new("Invalid discount rate #{discount_rate}. Should be a type of Integer.")
      end

      if discount_rate < 0 || discount_rate > 50
        raise ArgumentError.new("Invalid discont rate #{discount_rate}. Discount cannot be less that 0 or greater than 50.")
      end
    end

  end
end