
module Hotel
  class Room
    attr_reader :id, :cost

    def initialize(room_id, cost = 200.00) #reservations = nil
      raise ArgumentError if !room_id.is_a? Integer
      raise ArgumentError if room_id < 1
      @id = room_id
      @cost = cost
      #@reservations = reservations || []

    end

    # def add_reservation_to_room
    # end


    # def self.all


    # def find(date_range)
  

  end
end
