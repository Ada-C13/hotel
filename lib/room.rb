require 'awesome_print'
require 'date'

module Hotel
  class Room
  
  attr_reader :room_number, :rooms
  attr_accessor :price
    def initialize(room_number, price, rooms)
      @room_number = room_number
      @price = 200.00
      @rooms = []
    end
  end
end


