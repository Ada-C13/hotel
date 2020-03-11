module Hotel 
  class Room

    attr_reader :id, :cost
 
    def initialize(id: nil, cost: 200.00)

      @id = id
      @cost = cost  
    end 

  end 
end
