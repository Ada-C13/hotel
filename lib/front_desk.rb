require_relative 'room'
require_relative 'date_range'
require_relative 'reservations'
require_relative 'hotel_block'
require_relative 'no_available_room_error'

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
      available_rooms = check_block_status(date_range)
      
      raise NoAvailableRoomError.new("there are no available rooms for that date")if available_rooms.empty? == true

      chosen_room = available_rooms[0]
      new_reservation = Hotel::Reservation.new(date_range: date_range, room: chosen_room)
      @reservations << new_reservation
      chosen_room.add_room_reservation(new_reservation)
      return new_reservation
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
      if reservation.block_reservation == false
        total_cost = reservation.date_range.nights * reservation.room.cost 
      else
        total_cost = reservation.date_range.nights * reservation.room.cost * (1-reservation.room.discount_cost)
      end
      return total_cost
    end

    def check_block_status(date_range)
      available_rooms = available_rooms(date_range)
      @hotel_blocks.each do |hotel_block|
        if hotel_block.date_range.overlap?(date_range) == true
          hotel_block.rooms.each do |block_room|
           available_rooms.delete(block_room)
          end
        end
      end
      return available_rooms
    end

    def request_block(block_count, date_range, discount_cost)
      available_rooms = check_block_status(date_range)
      raise NoAvailableRoomError.new("Not enough available rooms to fulfill block") if available_rooms.count < block_count

      hotel_block = Hotel::HotelBlock.new(block_count: block_count, date_range: date_range, discount_cost: discount_cost)

      x = 0
      until x == block_count do
       available_room = available_rooms[x]
       available_room.change_cost(discount_cost)
        hotel_block.rooms << available_room
        x += 1
      end
      @hotel_blocks << hotel_block
      return hotel_block
    end 


    def available_rooms_in_block(hotel_block)
     available_rooms = hotel_block.rooms.select{|room| room.reservations.empty? == true || room.reservations.any?{|reservation| reservation.date_range.overlap?(hotel_block.date_range) == false}}
     return available_rooms
    end

    def add_reservation_to_room_in_block(hotel_block) 
      available_rooms = available_rooms_in_block(hotel_block)
      chosen_room = available_rooms[0]
      new_reservation = Hotel::Reservation.new(date_range: hotel_block.date_range, room: chosen_room)
      new_reservation.block_reservation = true
      @reservations << new_reservation
      chosen_room.add_room_reservation(new_reservation)
      return new_reservation
    end
  end
end
