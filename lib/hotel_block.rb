
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

  # keep this class light 
  # calculating cost might come here

  # def create_block_rooms
  #   block_rooms = []
  #   (1..@room_count).each do |x| 
  #     block_rooms << Room.new(number: x, cost: room_rate)
  #   end 
  #   return block_rooms
  # end
  
end