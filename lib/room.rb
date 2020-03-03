module Hotel
    class Room
        attr_reader :id, :status, :reservations
      def initialize(id:, status:, reservations:)
          @id = id
          @status = status
          @reservations = []
      end

      def self.list_of_rooms
        rooms = []
        id = 1
        20.times do
            room = Hotel::Room.new(id: id, status: true, reservations: [])
            rooms << room 
            id += 1
        end
        return rooms
    end

    end
  end