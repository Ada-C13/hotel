require 'time'


module Hotel
    class Receptionist
        attr_accessor :rooms, :reservations

      def initialize(rooms:,reservations:)
        @rooms = rooms
        @reservations = reservations
      end
    end
end
  