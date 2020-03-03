require_relative 'test_helper'

module Stayappy
  class Block_Res < Reservation
    def init(num_rooms_requested, total)
      @num_rooms_requested = num_rooms_requested
      @total = apply_discount()
    end 

    def available?(rooms)
      #Checks rooms to see if a given rooms are available
      #Raises ArgErr for invalid date range 
    end

    def apply_discount
      # applies discount for creating a block reservation 
    end


  end
end 

