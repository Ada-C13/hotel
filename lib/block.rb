module Hotel 
  class Block 

    @@ids = []

    attr_reader :date_range, :id, :rooms
 
    def initialize(date_range, id: nil, rooms: []) 
      @date_range = date_range
      @id = Block.generate_id
      @rooms = rooms
    end 

    # question - test coverage
    def self.generate_id 
      id = "BL000#{rand(111..999).to_s}"

      if @@ids.include?(id)
        id = "BL000#{rand(111..999).to_s}"
        @@ids << id
      end 
      return id
    end 
  end 
end 