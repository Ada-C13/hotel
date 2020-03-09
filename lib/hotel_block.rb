module Hotel
  class HotelBlock 
    attr_reader :date_range , :rooms , :discounted_rate
    def initialize(date_range, rooms, discounted_rate)
      @date_range = date_range
      raise ArgumentError.new("A block can contain a maximum of 5 rooms") if rooms.length > 5 
      raise ArgumentError.new("The hotel block cannot be made without having a room") if rooms.empty?
      @rooms = rooms
      @discounted_rate = 0.1
    end
  end
end


