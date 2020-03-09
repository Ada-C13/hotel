require_relative 'room'

module Hotel
  class HotelDispatcher
    attr_accessor :reservations, :rooms

    def initialize

      @reservations = []
      create_rooms
    end 

    # Wave 1 - Create 20 rooms. 
    def create_rooms
      @rooms = []
        (1..20).each do |room_num|
          room = Hotel::Room.new(room_num: 1)
          room.room_num = room_num
          @rooms << room
        end
        return @rooms
    end

    # Wave 1 - Make a new reservation.
    def make_reservation(start_date, end_date)
      if end_date < start_date
        raise ArgumentError
      end
      room = create_rooms[0]
      new_reservation = Hotel::Reservation.new(start_date: start_date, end_date: end_date, room: room)
      @reservations << new_reservation
      return @reservations
    end 

    # Wave 1 - Find all reservations for a given room and date range.
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
    end 

    # Wave 1 - Find all reservations for a given date. 
    def find_all_reservations(date)
      all_reservations_by_date = []
      @reservations.each do |reservation|
        if (date >= reservation.start_date && date < reservation.end_date)
          all_reservations_by_date << reservation
        end
      end
      return all_reservations_by_date
    end 

    # Wave 2 - Find available rooms for a given date range. 
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
    end

    # Wave 2 - Book available room with room number and date range. 
    def book_avail_room_w_date_range(room_number, start_date, end_date)
      available_rooms = find_available_rooms(start_date, end_date)
      # if room is NOT available - throw error
      if (available_rooms.all? { |room_object| room_number != room_object.room_num })
        raise ArgumentError, "The room number you entered is unavailable on the dates you entered."
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

  end 

end 
