module Hotel
  class HotelController
    attr_reader :rooms, :reservations

    def initialize
      @rooms = []
      @reservations = []
    end

    def add_room(room)
      @rooms << room
    end

    def list_all_rooms
      return @rooms
    end

    def total_cost(reservation)
      return reservation.total_cost
    end

    def find_available_rooms(given_date, leave_date = given_date)
      if leave_date == given_date
        unavailable_rooms = @reservations.select { |res| (res.arrive..res.depart).include?(given_date) }
      else
        unavailable_rooms = @reservations.select { |res| res.overlap?(given_date, leave_date) }
      end
      
      unavailable_room_nums = unavailable_rooms.map{ |res| res.room_num }
      available_rooms = @rooms.reject{ |room| unavailable_room_nums.include?(room.room_num)}
      return available_rooms
    end
    
    def reserve_room(arrive, depart)
      raise ArgumentError, "End date must be after start date" if depart < arrive || depart == arrive
      raise ArgumentError, "Arrival must be today or after today's date" if arrive < Date.today

      rooms = find_available_rooms(arrive, depart)
      raise ArgumentError, "Reservation can't be made, no available rooms" if rooms.empty?


      new_reservation = Hotel::Reservation.new(arrive, depart, rooms.first)
      @reservations << new_reservation
  
      return new_reservation
    end

    def reservations_by_date(given_date, second_date =given_date)
      if given_date == second_date
        return @reservations.select { |res| (res.arrive..res.depart).include?(given_date) }
      else
        return @reservations.select{ |res| res.overlap?(given_date, second_date) }
      end
    end

    def reservations_by_room_and_dates(given_room, *dates)
      raise ArgumentError,"Too many dates given for range" if dates.length > 2
      reservations = @reservations.select{ |res| res.room_num == given_room}

      if dates.empty?
        return reservations
      elsif dates.length == 1
        return reservations.select{ |res| (res.arrive..res.depart).include?(dates[0]) }
      else
        return reservations.select{ |res| res.overlap?(dates[0], dates[1]) }
      end
    end
  end
end