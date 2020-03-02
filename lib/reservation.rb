
require 'date'

module Hotel 
  class Reservation
    attr_reader :reservation_id, :date_range, :room_num
    def initialize(reservation_id:nil, date_range:, room_num:nil)

      @reservation_id = reservation_id
      @date_range = date_range
      @room_num = room_num
    end
  end 
end 