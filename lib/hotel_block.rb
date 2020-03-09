require 'date'
require_relative 'room'
require_relative 'reservations'

module Hotel
    class HotelBlock
        attr_accessor :date_in, :date_out, :number_of_rooms, :rooms_block

        @@increment_id = 1
      def initialize(date_in:,date_out:,number_of_rooms:, rooms_block:[], discounted_room_rate:)
        @id = @@increment_id 
        @@increment_id += 1
        @date_in = date_in
        @date_out = date_out
        @number_of_rooms = number_of_rooms
        # this range does not work, its an array of numbers
        #raise argument error unless (2..5).include? number_of_rooms 
        @rooms_block =[]
      end
    

    # def room_aside_for_date_range(start_date,end_date,room)
    #   range = date_in...date_out
    #   rooms_block.each do |room_in_block| 
    #     if room_in_block == room
    #       if range.include?(date)
    #         return :UNAVAILABLE
    #       end
    #     end
    #   end
    #   else return :AVAILABLE
    # end
      
  end
end
