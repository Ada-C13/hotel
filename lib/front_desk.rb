
module Hotel
  class FrontDesk
    attr_reader :rooms, :datarange

    def initialize
      @rooms = generate_rooms
    end
  
    def generate_rooms
      hotel_rooms = Array.new
        (1..20).each do |room_id|
          hotel_rooms << Room.new(room_id)
      end
      return hotel_rooms
    end

    def room_list
      return @rooms
    end
    
    def make_resevation(datarange,room)
      
      return Reservation.new(datarange, nil)
    end

    def reservations(date)
      return []
    end
  end
end