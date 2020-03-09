require_relative 'reservations'
require 'date'

module Hotel
    class Room
        attr_accessor :id, :reservations
      def initialize(id:, reservations:)
          @id = id
          @reservations = []
      end

      def self.list_of_rooms
        rooms = []
        id = 1
        20.times do
            room = Hotel::Room.new(id: id, reservations: [])
            rooms << room 
            id += 1
        end
        return rooms
      end

      def list_of_reservations_for_data_range(start_date,end_date)
        return reservations.select do |reservation|  
            overlap1 = start_date >= reservation.date_in && start_date < reservation.date_out
            overlap2 = end_date > reservation.date_in && end_date < reservation.date_out 
            overlap3 = start_date >= reservation.date_in && end_date < reservation.date_out
            overlap4 = start_date <= reservation.date_in && end_date >= reservation.date_out

            overlap1 || overlap2 || overlap3 || overlap4
        end
      end

      def specific_date_reservations(date)
        return reservations.select do |reservation| 
            range = reservation.date_in...reservation.date_out
            range.include?(date)
        end
      end

      def daterange_availability(date_in,date_out)
        if list_of_reservations_for_data_range(date_in,date_out) == []
          return :AVAILABLE 
        else
          return :UNAVAILABLE
        end
      end

      def specific_date_availability(date)
        list = []
        reservations.each do |reservation| 
            range = reservation.date_in...reservation.date_out
            if range.include?(date)
                list<< false
            end
        end
        return list
      end

      def test_overlap(start_date,end_date)
        reservations.each do |reservation|  
            overlap1 = start_date >= reservation.date_in && start_date < reservation.date_out
            overlap2 = end_date > reservation.date_in && end_date < reservation.date_out 
            overlap3 = start_date >= reservation.date_in && end_date < reservation.date_out
            overlap4 = start_date <= reservation.date_in && end_date >= reservation.date_out
            if (overlap1 == true) || (overlap2 == true) || (overlap3 == true) || (overlap4 == true)
              return true
            end
         end
         return false
      end
    end
end  