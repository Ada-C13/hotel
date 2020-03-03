require 'date'
require_relative 'room'

module Hotel
  class FrontDesk
    attr_accessor :rooms, :reservations, :date_range

    def initialize
      @rooms = []
      
      (1..20).each do |room_num|
        new_room = Room.new(room_number: room_num, cost: 200)
        @rooms << new_room
      end
      @reservations = []
      @date_range = []
    end

    # def add_reservation(date_range, room)
    #   id = (1...Float::INFINITY)
    #   @date_range = date_range
    #   @room = room
    #   new_reservation = reservations.new(id: id.shift, date_range: date_range, room: room)
    #   @reservations << new_reservation
    # end

    def find_room(room_number)
      front_desk = FrontDesk.new
      found_room = front_desk.rooms.select {|room| room.room_number == room_number}
      return found_room[0]
    end


    # def self.reservations
    #   @reservations = [] 
    #   return @reservations
    # end


  end
end
