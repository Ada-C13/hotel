module Hotel
  class HotelController
    attr_reader :rooms
    attr_accessor :reservations
    def initialize
      @rooms = Array.new(20){|i| Hotel::Room.new(i+1)}
      @reservations = []
    end
  
    # Wave 1

    # Access the list of all of the rooms in the hotel
    def self.rooms
        room_list = HotelController.rooms 
      return room_list
    end

    # Access the list of reservations for a specified room and a given date range
    def reservations_list_room_and_date(given_room, given_date_range)
      reservations_list_of_given_room_date_range = reservations.select do |res|
        res.date_range.overlap?(given_date_range) && res.room == given_room 
      end
      return reservations_list_of_given_room_date_range
    end

    # Add reservation to the list of the reservations
    def add_reservation(reservation)
      @reservations << reservation
    end 

    
    # Access the list of reservations for a specific date, so that I can track reservations by date
    def reservations_list(date)
      reservation_list = reservations.select do |res|
        res.date_range.include?(date)
        end 
        return reservation_list
    end

     # can get the total cost for a given reservation
    def total_cost(reservation)
      total_cost = reservation.cost
      return total_cost
    end

    # Wave 2

    # Create the new reservation 
    





    # I can view a list of rooms that are not reserved for a given date range, 
    # so that I can see all available rooms for that day
    def available_rooms(start_date, end_date)
      given_date_range = Hotel::DateRange.new(start_date, end_date)
      # get the reservations_list for the given date range
      reservations_list = reservations.select do |res|
        res.date_range.overlap?(given_date_range)
      end
      # get all the room that have been reserved for the given date range 
      all_reserved_rooms = reservations_list.map do |res|
        res.room
      end
      # get the aviable_rooms_list
      avialable_rooms_list = rooms.reject do |room|
        all_reserved_rooms.include?(room) 
      end
      return avialable_rooms_list
    end

  end
end

    # I can make a reservation of a room for a given date range, 
    # and that room will not be part of any other reservation overlapping that date range
    # done already in wave 1
  
    def reserve_room(start_date, end_date)
      given_date_range = Hotel::DateRange.new(start_date, end_date)
      # reservations_list = reservations.select do |res|
      #   res.date_range.overlap?(given_date_range)
      # end
      # all_reserved_rooms = reservations_list.map do |res|
      #   res.room
      # end

      # avialable_room = nil
      # rooms.each do |room|
      #   if !(all_reserved_rooms).include?(room) 
      #     avialable_room = room
      #     break # stop when find an avialable_room 
      #   end
      # end 

      # if avialable_room == nil 
      #   raise ArgumentError.new " no room"
      # end
      avialable_rooms_list = self.available_rooms(start_date, end_date)
      id = reservations.length + 1      
      reservation = Reservation.new(id,given_date_range, avialable_rooms_list[0])
      self.add_reservation(reservation)
      return reservation
    end

    # I want an exception raised if I try to reserve a room during a date range when all rooms are reserved, 
    # so that I cannot make two reservations for the same room that overlap by date

    # done already in wave 1
   
