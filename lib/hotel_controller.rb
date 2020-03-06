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

   # Add reservation 
    def add_reservation(reservation)
      @reservations << reservation
    end 

   # Create the new reservation 
    def reserve_room(start_date, end_date)
      # start_date and end_date should be instances of class Date
      given_date_range = Hotel::DateRange.new(start_date, end_date)
      reservations_list = reservations.select do |res|
        res.date_range.overlap?(given_date_range)
      end
      all_reserved_rooms = reservations_list.map do |res|
        res.room
      end

      avialable_room = nil
      rooms.each do |room|
        if !(all_reserved_rooms).include?(room) 
          avialable_room = room
          break # stop when find an avialable_room 
        end
      end 

      if avialable_room == nil 
        raise ArgumentError.new " no room"
      end


      id = reservations.length + 1      
      reservation = Reservation.new(id,given_date_range, avialable_room)
      self.add_reservation(reservation)
      return reservation

    end

    
    # access the list of reservations for a specified room and a given date range
    
   
    
    
    # access the list of reservations for a specific date, so that I can track reservations by date
    def reservations_list(date)
      reservation_list = reservations.select do |res|
        res.date_range.include?(date)
        end 
        return reservation_list
    end

     # can get the total cost for a given reservation



    # want exception raised when an invalid date range is provided, 
    # so that I can't make a reservation for an invalid date range
    # Wave 2
    def available_rooms(start_date, end_date)
      # start_date and end_date should be instances of class Date
      return []
    end
  end
end
