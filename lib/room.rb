module Hotel
  class Room
    attr_reader :reservations, :number, :cost
    attr_writer :cost

    def initialize(reservations = [], number, cost)
      @reservations = []
      @number = number
      @cost = cost
    end

    # TODO: determine why hotel_manager_test > list_reservations_by_room > returns the correct reservations is failing
    def check_availability(date_range)
      if @reservations.empty?
        return true
      else
        @reservations.each do |reservation|
          if (reservation.range & date_range.range).any?
            if (reservation.range[-1] == date_range.range[0]) || (reservation.range[0] == date_range.range[-1])
              next
            else
              return false
            end
          end
        end
        return true
      end
    end

  end
end