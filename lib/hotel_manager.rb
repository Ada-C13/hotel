require 'time'
require_relative 'room'
require_relative 'reservations'


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
      
    end
end
  