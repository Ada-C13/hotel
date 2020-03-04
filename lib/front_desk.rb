require 'date'
require_relative 'room'
require_relative 'date_range'
require_relative 'reservations'

module Hotel
  class FrontDesk
    attr_accessor :rooms, :reservations, :date_ranges

    def initialize
      @rooms = []
      
      (1..20).each do |room_num|
        new_room = Room.new(room_number: room_num, cost: 200)
        @rooms << new_room
      end
      @reservations = []
      @date_ranges = []
    end

    def add_reservation(date_range)
      id = (1..1000).to_a
      @date_ranges << date_range
      available_rooms = @rooms.select{|room| room.reservations.empty? == true} || @rooms.reject{|room| room.reservations.select{|reservation| reservation.date_range.overlap?(date_range)} == true}
      chosen_room = available_rooms.shift
      new_reservation = Hotel::Reservation.new(id: id.shift, date_range: date_range, room: chosen_room)
      @reservations << new_reservation
      chosen_room.add_room_reservation(new_reservation)
    end

    def available_rooms(date_range)
      available_rooms = @rooms.select{|room| room.reservations.empty? == true} || @rooms.reject{|room| room.reservations.select{|reservation| reservation.date_range.overlap?(date_range)} == true}
      return available_rooms
    end

    start_date = Date.new(2020,3,1)
    end_date = Date.new(2020,3,4)
    dates = Hotel::DateRange.new(start_date: start_date, end_date: end_date)
    front_desk = Hotel::FrontDesk.new

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
