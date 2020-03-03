require 'date'

module Hotel
  class FrontDesk
    attr_accessor :rooms, :reservations, :calendar
    
    def self.rooms
      @rooms = [] 
      
      (1..20).each do |room_num|
        new_room = Room.new(room_number: room_num, cost: 200)
        @rooms << new_room
      end
    end

    def initialize
      @reservations
      @calendar
    end


  end
end
