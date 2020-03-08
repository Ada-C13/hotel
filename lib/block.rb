module Hotel
  class Block
    attr_reader :date_range, :rate, :num_of_rooms
    
    def initialize(arrive, depart, rate, num_of_rooms)
      @date_range = Hotel::DateRange.new(arrive, depart)
      @rate = rate
      @num_of_rooms = num_of_rooms
    end
  end
end