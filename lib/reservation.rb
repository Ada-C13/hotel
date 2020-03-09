require 'date'
require 'time'
require_relative 'reservation'
require_relative 'date_range'
require_relative 'hotel_block'

module Hotel
  class Reservation
    attr_reader  :date_range
    attr_accessor :room_num, :status, :customer_name
    
    def initialize(date_range, customer_name)
      @date_range = date_range
      @room_num  =  nil
      @customer_name = customer_name
      @status = :comfirmed
      @cost = nil
    end

    def cost
      # offering discount to hotel block customers
      if @customer_name == "Hotel Block Reserve"
        @cost = ((@date_range.duration)* 150).to_f
      elsif
        # how many night times 200 per night
        @cost = ((@date_range.duration)* 200).to_f
      end
      return  @cost
    end

    # for hotel blocks - to check if request room is within the block
    def check_valid_room(request_room)
      return self.room_num == request_room
    end

    # for hotel blocks - to make sure it is still open for hotel block guests
    def check_status 
      return self.status == :open_hotel_block
    end
  end
end