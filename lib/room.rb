module Hotel
  class Room
    attr_reader :id, :reservations, :room_rate

    def initialize(id, room_rate=200)
      @id = id
      @reservations = []
      @room_rate = room_rate
    end

    # This method checks if room is available for a specific reservation or a general date range
    def available?(date_range)
      if reservations.length == 0
        return true
      end
      if reservations.any? {|r| r.overlap?(date_range)}
        return false
      else
        return true
      end
    end
    # TO DO refactor: from FrontDesk#reserve_room, take care of Reservation.new HERE, change method param to 
    # account for this. Additionally, take advantage of optional room_rate here. 
    # def add(reservation)
    #   if self.available?(reservation)
    #     @reservations << reservation
    #   else
    #     raise ArgumentError.new("Room #{self.id} isn't available for that reservation.")
    #   end
    # end
    def add(date_range)
      if date_range.class != Reservation && date_range.class != Block
        reservation = Reservation.new(date_range.start_date, date_range.end_date, self.id, room_rate)
      else
        reservation = date_range
      end
      if self.available?(reservation)
        @reservations << reservation
      else
        raise ArgumentError.new("Room #{self.id} isn't available for that reservation.")
      end
      return reservation
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
