module Hotel 
  class Room

    @@ids = []

    attr_reader :id, :cost
 
    def initialize(id: nil, cost: 200.00)

      @id = id
      @@ids << id
      
      @cost = cost  
    end 

  end 
end
