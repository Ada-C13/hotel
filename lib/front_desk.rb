require 'date'
require_relative 'room'
require_relative 'date_range'
require_relative 'reservations'

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

    # def add_reservation(date_range)
    #   id = (1..1000).to_a
    #   @date_range << date_range
    #   available_rooms = @rooms.select{|room| room.reservations.empty? == true} || @rooms.reject{|room| room.reservations.select{|reservation| reservation.date_range == date_range}}
    #   #the above doesn't validate if a room is booked from 3/1/20-3/5/20 and someone wants to book same room for 3/2/20-3/4/20
    #   chosen_room = available_rooms.shift
    #   new_reservation = Hotel::Reservation.new(id: id.shift, date_range: date_range, room: chosen_room)
    #   @reservations << new_reservation
    #   #i need to come back and check finish writing this code and it's tests
    #   chosen_room.add_room_reservation(new_reservation)
    # end

    def find_room(room_number)
      found_room = @rooms.select {|room| room.room_number == room_number}
      return found_room[0]
    end

    # def find_reservation_with(date_range)
    #   res_w_given_date = @reservations.select {|reservation| reservation.date_range == date_range}
    #   return res_w_given_date 
    # end


    # def self.reservations
    #   @reservations = [] 
    #   return @reservations
    # end


  end
end
