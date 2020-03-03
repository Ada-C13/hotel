require_relative 'test_helper'

module Stayappy
  class Reservation
    attr_reader room_num:, res_num: 

    def init(check_in:, check_out:, res_num:, room_num:, total:)
      @check_in = check_in
      @check_out = check_out
      @res_num = res_num
      @room_num = room_num
      @total = total
    end
  
    def assign_room 
      #Selects room(s) for the dates supplied 
    end

    def receipt
      #Calculates the entire cost of stay
    end


  end 
end 