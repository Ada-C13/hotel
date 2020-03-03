module Hotel
  class Room
    attr_reader :reservations, :number, :cost
    attr_writer :cost

    def initialize(reservations = [], number, cost)
      @reservations = []
      @number = number
      @cost = cost
    end

    def check_availability(daterange)
      if @reservations.empty?
        return true
      else
        reservations.each do |reservation|
          if (reservation.range[-1] == daterange.range[0])
            next
          elsif (reservation.range & daterange.range).any?
            return false
          end
        end
        return true
      end
    end

  end
end