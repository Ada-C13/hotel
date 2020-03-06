require_relative 'date_range'

module Hotel
  class Room
    attr_reader :reservations, :number, :cost
    attr_writer :cost

    def initialize(number, cost, reservations = [])
      @number = number
      @cost = cost
      @reservations = []
    end

    def check_availability(date_range)
      return true if @reservations.empty?
      @reservations.each do |reservation|
        # return false if dates overlap, else continue
        reservation.date_range.overlap?(date_range) ? (return false) : next
      end
      return true
    end

    def list_reservations(date = nil)
      return @reservations if !date
      raise ArgumentError.new("Only date or date_range should be provided, not both") if date.class != Date && date.class != Hotel::DateRange

      return find_reservations(date)
    end

    # helper method for list_reservations
    def find_reservations(date)
      reservations = []
      @reservations.each do |reservation|
        if date.class == Hotel::DateRange
          (reservations << reservation) if reservation.date_range.overlap?(date)
        else
          (reservations << reservation)if reservation.date_range.range.include?(date)
        end
      end
      return reservations
    end
    
  end
end