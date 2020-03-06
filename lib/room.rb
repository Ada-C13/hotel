require_relative 'hotel_controller'

module Hotel
  class Room
    attr_reader :room_num, :rate
    
    def initialize(room_num)
      @room_num = room_num
      @rate = 200
    end
  end
end