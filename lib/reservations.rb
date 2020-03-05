require 'date'
require_relative 'room'
require_relative 'hotel_manager'

module Hotel
  class Reservations

    attr_reader :id, :date_in, :date_out, :room_id
    
    @@increment_id = 1
    def initialize(date_in:, date_out:, room_id:, room:)
        @id = @@increment_id
        @@increment_id += 1
        @date_in = date_in
        @date_out = date_out
        @room_id = nil
        @room = nil

        if room
            @room = room
            @room_id = room.id
    
          elsif room_id
            @room_id = room_id

        else
            raise ArgumentError, 'room or room_id is required'
          end
        
        if room.test_overlap(date_in,date_out) == true
            raise ArgumentError
        end 

        unless @date_out >= @date_in 
            raise ArgumentError
        end  
    end

    def total_number_of_nights_per_reservation
       return  @date_out - @date_in 
    end
    
    # def add_a_reservations(date_in,date_out)


    # end

  end
end