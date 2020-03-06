module Hotel 
  class Room

    @@ids = []

    attr_reader :id, :cost

    def initialize(id: nil, cost: 200.00)

      Room.validate_id(id)

      @id = id 
      @cost = cost  
    end 

    # TO DO - test
    def self.validate_id(id)
      raise ArgumentError, "The id #{id} already exists in our system" if @@ids.include?(id)

      raise ArgumentError, "The id is between 1 and 20." if @@ids.length > 20
    end 
  end 
end
