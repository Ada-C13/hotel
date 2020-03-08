module Hotel
  class Block
    attr_reader :date_range, :rate, :num_of_rooms, :block_id

    def initialize(arrive, depart, rate, num_of_rooms)
      @date_range = Hotel::DateRange.new(arrive, depart)
      @rate = rate
      @num_of_rooms = num_of_rooms
      @block_id = make_id
    end

    def make_id
      1234
      # rand(1111..9999)
    end
  end
end