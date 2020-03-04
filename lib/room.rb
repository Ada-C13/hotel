module Hotel
  class Room
    attr_reader :reservations, :number, :cost
    attr_writer :cost

    def initialize(reservations = [], number, cost)
      @reservations = []
      @number = number
      @cost = cost
    end

    def check_availability(date_range)
      if @reservations.empty?
        return true
      else
        @reservations.each do |reservation|
          if (reservation.range[-1] == 
            date_range.range[0])
            next
          elsif (reservation.range & date_range.range).any?
            return false
          end
        end
        return true
      end
    end

  end
end