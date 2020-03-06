require 'date'
require_relative 'room'
require_relative 'reservations'
require_relative 'hotel_block'


module Hotel
    class HotelManager
        attr_accessor :rooms

      def initialize(rooms:)
        @rooms = @Hotel::Room.list_of_rooms
      end

      
      def list_reservations_on_specific_date(date)
        list =[]
        @rooms.each do |room|
          unless room.specific_date_reservations(date) == []
          list<<  room.specific_date_reservations(date)
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

      def total_cost(reservation)
        return reservation.total_number_of_nights_per_reservation * 200
      end

      def add_room_to_block(hotelblock,numberofrooms)
        numberofrooms.times do
          rooms.each do |room|
            if room.test_overlap(start_date,end_date) == false
              hotelblock.rooms_block<< room
          end
        end
      end
        if hotelblock.room_block.length < numberofrooms
          hotelblock.room_block = []
          raise ArgumentError, 'Not enough rooms to book for this block'
        end
      end

      
    end
end
  