
module HotelBooking
  class HotelBlock
    attr_reader :date_range, :room_count, :discount_rate, :rooms
    attr_writer :rooms
    def initialize(date_range:, room_count:, discount_rate:)
      @date_range = date_range
      @room_count = room_count
      @discount_rate = discount_rate
      @rooms = []
    end
  end
 
  # calculating cost might come here

  
end