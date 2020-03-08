module Hotel 
  class Reservation

    DISCOUNT = 0.8
    @@ids = []

    # date_range is an instance of DateRange class
    # room is an instance of Room class
    attr_reader :date_range, :room, :id, :block

    def initialize(date_range, id: nil, room: nil, block: nil)

      @date_range = date_range

      @id = Reservation.generate_id  # Invoke class method

      if block == nil 
        @room = room  #room_number TO DO  
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


    # TO DO (Add test)
    def self.generate_id 
      id = rand(111111..999999).to_s

      if @@ids.include?(id)
        id = rand(111111..999999).to_s
        @@ids << id
      end 

      return id
    end 
  end 
end 