module Hotel
  class Room
  # Responcibility: to reserve individual rooms
    attr_reader :id, :reservations, :block_participation

    def initialize(id)
      @id = id
      @reservations = []
      @block_participation = []
    end

    def available?(start_date:, end_date:)
      date_range = DateRange.new(start_date: start_date, end_date: end_date)
      reservations.each do |reservation|
        if reservation.date_range.overlap? (date_range)
          return false
        end
      end
      block_participation.each do |block_reservation|
        if block_reservation.date_range.overlap? (date_range)
          return false
        end
      end
      return true
    end

    def reserve(start_date:, end_date:, block: nil)
      unless available?(start_date: start_date, end_date: end_date) 
        raise StandardError.new("Room #{id} is unavailabe for requested dates.") 
      end
      reservation = new_reservation(start_date: start_date, end_date: end_date) 
      block ? add_block_participation(reservation) : add_reservation(reservation)
    end

    def select_reservations(date_range)
      reservations.select { |reservation| reservation.date_range.overlap? (date_range)}
    end

    private
      def new_reservation(start_date:, end_date:) 
        reservation = Reservation.new(room_id: id, start_date: start_date, end_date: end_date)
      end

      def add_reservation(reservation)
        reservations << reservation
      end  

      def add_block_participation(reservation)
        block_participation << reservation
      end
  end
end
