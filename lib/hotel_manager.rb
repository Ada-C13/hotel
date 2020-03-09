require 'date'
require_relative 'room'
require_relative 'reservations'
require_relative 'hotel_block'


module Hotel
  class HotelManager
    attr_accessor :rooms, :blocks

    def initialize(rooms:,blocks:)
      @rooms = @Hotel::Room.list_of_rooms
      @blocks = []
    end

    def book_a_room(date_in,date_out,room)
      if room.daterange_availability(date_in,date_out) == :AVAILABLE
      reservation = Hotel::Reservations.new(date_in: date_in , date_out: date_out, room_id: room.id, room: room)
      add_a_reservation_to_room(room,reservation)
      else 
        raise ArgumentError, 'Room is UNAVAILABLE'
      end
    end

    def add_a_reservation_to_room(room, reservation)
      room.reservations<< reservation
    end
    
    def list_reservations_on_specific_date(date)
      list =[]
      @rooms.each do |room|
        unless room.specific_date_reservations(date) == []
          room.specific_date_reservations(date).each do |reservation|
            list<< reservation
          end
        end
      end
      return list
    end

    def list_available_rooms_on_specific_date(date)
      list =[]
      @rooms.each do |room|
        if room.specific_date_availability(date) == []
          list<<  room
        end
      end
      return list
    end

    def total_cost(reservation, rate= 200)
      return reservation.total_number_of_nights_per_reservation * rate
    end

    def book_a_block(date_in,date_out,numberofrooms,rate)
      block = Hotel::HotelBlock.new(date_in: date_in ,date_out: date_out, number_of_rooms: numberofrooms, rooms_block: [], discounted_room_rate: rate)
      add_rooms_to_block(block,numberofrooms)
      @blocks<< block
      return block
    end

    def add_rooms_to_block(hotelblock,number_of_rooms_needed)
      number_of_available_rooms = 0
      rooms.each do |room|
        if room.list_of_reservations_for_data_range(hotelblock.date_in,hotelblock.date_out) == []
          number_of_available_rooms +=1
        end
      end
      if number_of_available_rooms < number_of_rooms_needed
        raise ArgumentError, "Not enough room AVAILABILITY for this Block! Only #{number_of_available_rooms} AVAILABLE"
      else
        rooms_added = 0
        rooms.each do |room| 
          reservation = @Hotel::Reservations.new(date_in: hotelblock.date_in, date_out:hotelblock.date_out, room_id: room.id , room: room )
          room.reservations << reservation
          hotelblock.rooms_block<< room
          rooms_added +=1
          if rooms_added == number_of_rooms_needed
            return
          end
        end
      end
    end

  end
end
  