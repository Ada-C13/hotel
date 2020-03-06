require 'date'
require_relative 'room'
require_relative 'reservations'

module Hotel
    class HotelBlock
        attr_accessor :date_in, :date_out, :number_of_rooms

      def initialize(date_in:,date_out:,number_of_rooms: (2..5), rooms_block:[],discounted_room_rate:)
        @date_in = date_in
        @date_out = date_out
        @number_of_rooms = (2..5)
        @rooms_block =[]
      end
    end
end
