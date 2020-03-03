module Hotel
  class FrontDesk
    
    attr_reader :all_reservations, :rooms
    
    def initialize
      @all_reservations = all_reservations || []
      @rooms = [*1..20]
    end

    def add_reservation(start_date, end_date, num_rooms)
      new_reservation = Hotel::Reservation.new(start_date: start_date, end_date: end_date, num_rooms: num_rooms)
      @all_reservations << new_reservation
    end

  end
end