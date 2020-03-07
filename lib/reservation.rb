require "date"
require_relative "date_range"

module Hotel
  class Reservation
    attr_reader :id, :date_range, :room_num


    def initialize(date_range, room_num) 
      #(num, instance of DateRange, room_num)
      # unless id.is_a?(Integer) && id > 0
      #   raise ArgumentError.new("ID must be a positive integer (got #{id}).")
      # end

      # unless room_num.is_a?(Integer) && room_num >= 1 && room_num <= 20
      #   raise ArgumentError.new("Room number must be integer between 1 to 20 (got #{room_num}).")
      # end

      @date_range = date_range
      @room_num = room_num
    end



    def total_price
      return (@date_range.nights) * 200
    end

    


  end
end
