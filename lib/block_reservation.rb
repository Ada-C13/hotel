require "date"
require_relative "date_range"

module Hotel
  class BlockReservation
    attr_reader :name, :date_range, :room_num, :discount_rate, :status

    def initialize(name, date_range, room_num, discount_rate, status = :AVAILABLE) 
      @name = name
      @date_range = date_range
      @room_num = room_num
      @discount_rate = discount_rate
      @status = status
    end

    def change_room_status
      if @status == :AVAILABLE
        @status = :UNAVAILABLE
      end
    end
  end
end
