require 'date'
require_relative 'room'
require_relative 'reservations'

module Hotel
    class HotelBlock
        attr_accessor :date_in, :date_out, :number_of_rooms, :rooms_block


      def initialize(date_in:,date_out:,number_of_rooms: , rooms_block:[], discounted_room_rate:)
        @date_in = date_in
        @date_out = date_out
        @number_of_rooms = number_of_rooms
        # this range does not work, its an array of numbers
        #raise argument error unless (2..5).include? number_of_rooms 
        @rooms_block =[]
      end
    end
end
