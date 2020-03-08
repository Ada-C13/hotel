require_relative 'room'

module Hotel
  class HotelDispatcher
    attr_accessor :reservations, :rooms

    def initialize

      @reservations = []
      create_rooms
    end #initialize end

    # Wave 1
    def create_rooms
      @rooms = []
        (1..20).each do |room_num|
          room = Hotel::Room.new(room_num: 1)
          room.room_num = room_num
          @rooms << room
        end
        return @rooms
    end # create rooms end

    # Wave 1
    def make_reservation(start_date, end_date)
      if end_date < start_date
        raise ArgumentError
      end
      room = create_rooms[0]
      new_reservation = Hotel::Reservation.new(start_date: start_date, end_date: end_date, room: room)
      @reservations << new_reservation
      return @reservations
    end

    # Wave 1 Access all reservations for a specific room
    def find_all_res_for_room(room_num, start_date, end_date)
      found_reservations = []
        @reservations.each  do |reservation| 
          next if reservation.room.room_num != room_num
            if ((start_date > reservation.start_date && start_date < reservation.end_date) ||
            (end_date > reservation.start_date && start_date < reservation.end_date)) || 
            (reservation.start_date < start_date && reservation.end_date > end_date)
              found_reservations << reservation
            end
        end
        return found_reservations
    end # find_all_res_for_room end


    # Wave 1 - Access list of reservations for a specific date. 
    def find_all_reservations(date)
      all_reservations_by_date = []
      @reservations.each do |reservation|
        if (date >= reservation.start_date && date < reservation.end_date)
          all_reservations_by_date << reservation
        end
      end
      return all_reservations_by_date
    end #find_all_reservations by date end



      # Wave 2 -  View all available rooms for a given date range
    def find_available_rooms(start_date, end_date)
      found_rooms = @rooms.clone
      @reservations.each do |reservation|
        if (start_date >= reservation.start_date && end_date < reservation.end_date) ||
          (start_date < reservation.start_date && end_date < reservation.end_date) ||
          (start_date < reservation.end_date && end_date > reservation.end_date)
          found_rooms.reject! do |room|
            room.room_num == reservation.room.room_num
          end
        end
      end
      return found_rooms
    end # find_available_rooms end


    # Wave 2 Book available room with specific room number and date range.
    def book_avail_room_w_date_range(room_number, start_date, end_date)
      available_rooms = find_available_rooms(start_date, end_date)
      if (available_rooms.all? { |room_object| room_number != room_object.room_num })
        raise ArgumentError, "The room number you have entered is unavailable"
      # .any returns true if at least one element meets the condition
      elsif (available_rooms.any? { |room_object| room_number == room_object.room_num })
        # .find returns the first element that satisfies the condition
        found_room = available_rooms.find { |room_object| room_object.room_num == room_number } 
        new_reservation = Hotel::Reservation.new(start_date: start_date, end_date: end_date, room: found_room)
        @reservations << new_reservation
        return true
      else
        return false
      end
      
    end
    


  end # class end
end # module end


# reservations that do not conflict
# if (start_date >= reservation.end_date && end_date >= reservation.end_date) 
#   (start_date < reservation.start_date && end_date <= reservation.start_date) ||
#   (start_date >= reservation.end_date && end_date > reservation.end_date)
#   found_rooms << reservation
# else 