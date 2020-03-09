module Hotel 
  class Block 

    @@ids = []

    attr_reader :date_range, :rooms
 
    def initialize(date_range, rooms: []) 
      @date_range = date_range
      @rooms = rooms
    end 
  end 
end 