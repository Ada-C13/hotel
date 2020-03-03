require_relative 'test_helper'

module Stayappy
  class Ind_Res < Reservation
    def init(ind_res.new)
      super(check_in, check_out, res_num, room_num, total)
    end 

    def available?(room_num)
      #Checks rooms to see if a given room is available
      #Raises ArgErr for invalid date range 
    end



  end
end 