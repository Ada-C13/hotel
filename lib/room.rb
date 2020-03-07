module Hotel
  class Room
  # Responcibility: to reserve individual rooms
    attr_reader :id, :reservations

    def initialize(id)
      @id = id
      @reservations = []
    end

    def available?(start_date:, end_date:)
      date_range = DateRange.new(start_date: start_date, end_date: end_date)
      reservations.each do |reservation|
        if reservation.date_range.overlap? (date_range)
          return false
        end
      end
      return true
    end

    def reserve(start_date:, end_date:)
      unless available?(start_date: start_date, end_date: end_date) 
        raise StandardError.new("Room is unavailabe for requested dates.") 
      end
      reservation = new_reservation(start_date: start_date, end_date: end_date) 
      add_reservation(reservation)
    end

    private
      def new_reservation(start_date:, end_date:) 
        reservation = Reservation.new(room_id: id, start_date: start_date, end_date: end_date)
      end

      def add_reservation(reservation)
        reservations << reservation
      end
  end
end
