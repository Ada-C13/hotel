
module Hotel
  class Room
    attr_reader :room_number
    attr_accessor :cost, :reservations, :discount_cost
    
    def initialize(room_number:, cost:, reservations: nil)
      @room_number = room_number

      raise ArgumentError.new("There are only 20 rooms") if room_number < 1 || room_number > 20

      @cost = 200
      @reservations = reservations || []
      @discount_cost = 0

    end

    def add_room_reservation(reservation)
      @reservations << reservation
    end

    # def change_cost(discount_cost) 
    #   self.cost = discount_cost
    #   return self
    # end

    # def change_block_status
    #   self.block_status = :in_block #rooms status should only be this for the duration (date_range) of block
    #   return self
    # end


    # def change_availability_in_block 
    #   self.availability_in_block = :unavailable
    #   return self
    # end

  end
end

# room = Hotel::Room.new(room_number: 1, cost: 200)
# puts room.change_cost(180)
# puts room.cost