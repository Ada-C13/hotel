require_relative 'date_range'

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
          if reservation.date_range.overlap?(date_range)
            return false
          else
            next
          end
        end
        return true
      end
    end

    def calculate_cost(reservation)
      reservation.total_cost = reservation.nights * cost
    end

  end
end