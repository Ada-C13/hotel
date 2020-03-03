
module Hotel
  class FrontDesk
    attr_reader :rooms, :datarange

    def room_list
      return []
    end
    
    def make_resevation(datarange,room)
      return Reservation.new(datarange, nil)
    end

    def reservations(date)
      return []
    end
  end
end