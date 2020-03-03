module Hotel
    class Room
      def initialize(id:, status:, reservations:)
          @id = id
          @status = status
          @reservations = []
      end
    end
  end