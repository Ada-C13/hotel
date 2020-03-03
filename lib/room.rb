
module Hotel
  class Room
    attr_reader :id, :cost

    def initialize(room_id, cost = 200)
      raise ArgumentError if !room_id.is_a? Integer
      raise ArgumentError if room_id < 1 || room_id > 20
      @id = room_id
      @cost = cost
    end

    # def find(date_range)
    # end

  end
end
