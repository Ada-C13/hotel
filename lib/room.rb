require_relative 'hotel_controller'

module Hotel
  class Room
    attr_reader :room_num, :rate, :reservations
    
    def initialize(room_num)
      @room_num = room_num
      @rate = 200
      @reservations = []
    end
  end
end