require 'date'
require_relative 'room'
require_relative 'hotel_manager'

module Hotel
  class Reservations

    attr_accessor :id, :date_in, :date_out, :room_id
    
    @@increment_id = 1
    def initialize(date_in:, date_out:, room_id: , room: )
      @id = @@increment_id
      @@increment_id += 1
      @date_in = date_in
      @date_out = date_out
      @room_id = room_id
      @room = room

      unless date_out >= date_in 
        raise ArgumentError, 'you cannot have date out come before date in'
      end 

      if room.test_overlap(date_in,date_out)
          raise ArgumentError, 'there is an overlap'
      end  
    end

    def total_number_of_nights_per_reservation
      return  date_out - date_in 
    end

  end
end