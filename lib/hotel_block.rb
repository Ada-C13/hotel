require 'date'
require 'time'
require_relative 'reservation'
require_relative 'date_range'


module Hotel
  class BlockReservation 
    attr_reader  :date_range, :status
    attr_accessor :room_num , :no_of_rooms, :block_reservations
    
    def initialize(date_range, no_of_rooms)
      @date_range = date_range
      @no_of_rooms = no_of_rooms
      @block_reservations = Array.new
    end
  end
end