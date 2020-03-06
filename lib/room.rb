module Hotel
  class Room
    attr_reader :id, :reservations

    def initialize(id)
      @id = id
      @reservations = []
    end
    
    def available?(date_range)
      if reservations.length == 0
        return true
      end
      # TO DO make this more ready by using any? or all?
      if reservations.any? {|r| r.overlap?(date_range)}
        return false
      else
        return true
      end
    end

    
    def add(reservation)
      # to do: is this check redundant, since front desk checks
      if self.available?(reservation)
        @reservations << reservation
      else
        raise ArgumentError.new("That room isn't available.")
      end
    end

    def get_reservations(start_date, end_date)
      range = DateRange.new(start_date, end_date)
      resv_within = reservations.find_all {|reservation|
          reservation.nights.all? {|night| range.include?(night)}
        }
      return resv_within
    end

  end
end
