require_relative 'hotel_controller'

module Hotel
  attr_reader :room_num, :rate

  class Room
    def initialize(room_num)
      @room_num = room_num
      @rate = 200
    end

  end
end