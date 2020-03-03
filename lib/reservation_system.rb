require 'time'
require 'awesome_print'

require_relative 'room'
require_relative 'reservation'


module Hotel
    class ReservationSystem
      attr_reader :rooms, :reservations
        
      def initialize()
        @rooms = Room.load_all_rooms()
        @reservations = Reservation.load_all_reservations()
      end
    end
  end

  test = Hotel::ReservationSystem.new
  puts test.rooms