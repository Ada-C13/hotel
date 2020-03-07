module Hotel 
  class Reservation

    DISCOUNT = 0.8
    @@ids = []

    # date_range is an instance of DateRange class
    # room is an instance of Room class
    attr_reader :date_range, :room, :id, :is_block

    def initialize(date_range, room, id: nil, is_block: false)

      @date_range = date_range
      @room = room  #room_number TO DO
      
      @id = Reservation.generate_id  # Invoke class method
      @is_block = is_block
    end 

    def total_cost 
      if @is_block == true 
        total_cost = @date_range.nights * (@room.cost * DISCOUNT)
        return total_cost.to_f.round(2)
      end 

      return (@date_range.nights * @room.cost).to_f.round(2) 
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