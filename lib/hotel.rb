require 'time'


module Hotel
    class FrontDesk
        attr_accessor :rooms, :reservations

      def initialize(rooms:,reservations:)
        @rooms = rooms
        @reservations = reservations
      end
    end
end
  