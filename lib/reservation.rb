
require 'securerandom'

module Hotel

  class Reservation

    attr_reader :daterange, :room, :id
    
    def initialize(daterange, room)
      @daterange = daterange
      @room = room
      @id = generate_id
    end
    
    # It retuns a secureRandom ID per each reservation made.
    def generate_id
      return SecureRandom.hex(5)
    end
    
    def total_cost
      return daterange.nights * @room.cost
    end
  end
end