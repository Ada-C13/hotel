module Hotel 
  class Block 

    attr_reader :date_range, :rooms, :reservation 

    def initialize(date_range, rooms = [], reservation) 
      @date_range = date_range
      @rooms = rooms
      @reservation = reservation
    end 

    def total_block_cost 
      return (rooms.length * @reservation.total_cost).to_f.round(2)
    end 

  end 
end 