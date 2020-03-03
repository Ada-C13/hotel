
require 'date'

module Hotel 
  class Reservation
    attr_reader :reservation_id, :date_range, :room_num
    def initialize(reservation_id:nil, date_range:, room_num:nil)

      @reservation_id = reservation_id
      @date_range = date_range
      @room_num = room_num

      if @room_num == nil 
        @room_num = rand(1..20)
      end 

      if @reservation_id == nil
        @reservation_id = rand(1000..9999)
      end


    end
  end 
end 

#assign logic on how to assign room num
