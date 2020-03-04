require 'date'
require 'time'
require './lib/date_range.rb'
require './lib/hotel_controller.rb'

module Hotel
  class Reservation
    attr_reader  :date_range,  :room_num
    
    def initialize(date_range, room_num)
      @date_range = date_range
      @room_num  =  room_num
      @status = :comfirmed

      raise ArgumentError.new("Please enter a valid room number. There are only 20 rooms in this hotel") if @room_num > 20 || @room_num <= 0
    end

    def cost
      # how many night times 200 per night
      return (@date_range.duration)* 200 
    end
  end
end