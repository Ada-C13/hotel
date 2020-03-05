require 'date'
require 'time'
require './lib/date_range.rb'
require './lib/hotel_controller.rb'

module Hotel
  class Reservation
    attr_reader  :date_range, :customer_name
    attr_accessor :room_num
    
    def initialize(date_range, customer_name)
      @date_range = date_range
      @room_num  =  nil
      @customer_name = customer_name
      @status = :comfirmed
      @cost = nil
    end

    def cost
      # how many night times 200 per night
        @cost = ((@date_range.duration)* 200).to_f
      return  @cost
    end
  end
end