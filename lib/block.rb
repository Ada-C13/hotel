require_relative 'room'
require_relative 'date_range'
require_relative 'reservation'


module Hotel
  class Block < Reservation
    attr_reader :block

    def initialize(date_range, room_id, cost = 200.00, block = 0)  
      
      super(date_range, room_id, cost)
      @block = block
      
    end
  end
end