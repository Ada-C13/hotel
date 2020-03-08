require 'Date'


module Hotel
  class Block
    attr_accessor :block_id

    def initialize(date_range, collection_of_rooms, discount_rate, hotel_controller, block_id = nil)
      @date_range = date_range
      @discount_rate = discount_rate
      @collection_of_rooms = collection_of_rooms
      @hotel_controller = hotel_controller
      @block_id = block_id

      hotel_controller.block_available(date_range, collection_of_rooms)

    
    end
  end
end


