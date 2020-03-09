module Hotel 
  class Reservation

    DISCOUNT = 0.8
    @@ids = []

    # date_range is an instance of DateRange class
    # room is an instance of Room class
    attr_reader :date_range, :room, :block

    def initialize(date_range, room: nil, block: nil)

      @date_range = date_range

      if block == nil 
        @room = room  #room_number TO DO (Maybe I want to refactor as room numbers)
      else 
        @block = block
      end       
    end 

    def individual_total_cost 
      return (room.cost * @date_range.nights).to_f.round(2) 
    end 

    def block_total_cost 
      cost_per_room = block.rooms[0].cost * DISCOUNT
      number_of_rooms = block.rooms.length

      total_cost = (cost_per_room * number_of_rooms) * @date_range.nights

      return total_cost.to_f.round(2)
    end 
  end 
end 