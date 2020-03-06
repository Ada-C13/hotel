require_relative 'room'
require_relative 'date_range'
require_relative 'reservations'
require_relative 'hotel_block'

module Hotel
  class FrontDesk
    attr_accessor :rooms, :reservations, :hotel_blocks

    def initialize
      @rooms = []
      
      (1..20).each do |room_num|
        new_room = Room.new(room_number: room_num, cost: 200)
        @rooms << new_room
      end
      @reservations = []
      @hotel_blocks = []
    end

    def add_reservation(date_range)
      available_rooms = available_rooms(date_range)
      raise NoAvailableRoomError.new("there are no available rooms for that date")if available_rooms.empty? == true

      chosen_room = available_rooms.shift
      new_reservation = Hotel::Reservation.new(date_range: date_range, room: chosen_room)
      @reservations << new_reservation
      chosen_room.add_room_reservation(new_reservation)
    end

    def available_rooms(date_range)
      available_rooms = @rooms.reject do |room|
        room.reservations.any?{|reservation| reservation.date_range.overlap?(date_range) == true}
      end
      return available_rooms
    end

    def find_reservation_with(room: nil, date_range:)
      res_w_given_date = @reservations.select {|reservation| (reservation.date_range == date_range && reservation.room == room) || reservation.date_range == date_range }
      return res_w_given_date 
    end

    def total_cost(reservation)
      total_cost = reservation.date_range.nights * reservation.room.cost
      return total_cost
    end

  #   start_date = Date.new(2020,3,1)
  #   end_date = Date.new(2020,3,4)
  #   dates = Hotel::DateRange.new(start_date: start_date, end_date: end_date)
  #   front_desk = Hotel::FrontDesk.new
  #   room = front_desk.rooms[0]

  #   front_desk.add_reservation(dates)
  #  p front_desk.find_reservation_with( date_range: dates)
  #  puts "\n"
  #  p front_desk.find_reservation_with( room: room, date_range: dates)
    


  end
end
