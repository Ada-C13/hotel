module Hotel
  class FrontDesk 
    attr_reader :rooms, :reservations
    def initialize
        @rooms = []
        @reservations = []
    end

    def reserve_room(start_date, end_date)
      new_reserv = nil
    end

  end
end