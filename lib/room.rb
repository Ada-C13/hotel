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
      return true if @reservations.empty?
      @reservations.each do |reservation|
        # return false if dates overlap, else continue
        reservation.date_range.overlap?(date_range) ? (return false) : next
      end
      return true
    end
  end
end