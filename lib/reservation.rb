
require 'securerandom'

module Hotel

  class Reservation

    attr_reader :daterange, :room, :id
    
    def initialize(daterange, room)
      @daterange = daterange
      @room = room
      @id = generate_id
    end

    def generate_id
      id = SecureRandom.hex(5)
    end
    
    def total_cost
      total_cost = (daterange.nights * @room.cost)
      return total_cost
    end
  end
end