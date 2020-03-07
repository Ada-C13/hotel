module Hotel
  class HotelController
    attr_reader :rooms
    attr_accessor :reservations, :hotel_blocks
    def initialize
      @rooms = Array.new(20){|i| Hotel::Room.new(i+1)}
      @reservations = []
      @hotel_block = [] #contain a number of rooms and a specific set of days
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
    # Get reserved_rooms_list 

    def reserved_rooms_list(start_date, end_date)
      given_date_range = Hotel::DateRange.new(start_date, end_date)
      # get the reservations_list for the given date range
      reservations_list = reservations.select do |res|
      res.date_range.overlap?(given_date_range)
      end

      # get all the room that have been reserved for the given date range 
      all_reserved_rooms = reservations_list.map do |res|
        res.room
      end
      return all_reserved_rooms 
    end 

    # I can view a list of rooms that are not reserved for a given date range, 
    # so that I can see all available rooms for that day
    def available_rooms(start_date, end_date)
      given_date_range = Hotel::DateRange.new(start_date, end_date)
      # get all the room that have been reserved for the given date range 
      all_reserved_rooms = reserved_rooms_list(start_date, end_date)

      # get the aviable_rooms_list
      avialable_rooms_list = rooms.reject do |room|
        all_reserved_rooms.any? do |reserved_room|
          reserved_room.id == room.id 
        end
      end
      return avialable_rooms_list
    end

    # I can make a reservation of a room for a given date range, 
    # and that room will not be part of any other reservation overlapping that date range
    # done already in wave 1
  
    def reserve_room(start_date, end_date)
      given_date_range = Hotel::DateRange.new(start_date, end_date)
      avialable_rooms_list = available_rooms(start_date, end_date)
      if avialable_rooms_list.empty?
        raise NoRoomAvailableError.new("there is no available room.")
      end
      id = reservations.length + 1      
      reservation = Hotel::Reservation.new(id,given_date_range, avialable_rooms_list.first)
      add_reservation(reservation)
      return reservation
    end  

    # Wave 3

    # Add hotel_block method

    def add_hotel_block(hotel_block)
      @hotel_blocks << hotel_block
    end
    
    #Create a hotel_block
    def create_hotel_block(date_range, rooms_array, discount_rate)
      # all rooms of rooms_array must be available room during the given date range
      all_reserved_rooms = reserved_rooms_list(start_date, end_date)
      
      # an exception raised if I try to create a Hotel Block 
      # and at least one of the rooms is unavailable for the given date range
      
      @rooms.each do |room|
        if all_reserved_rooms.any?(room)
          raise ArgumentError.nw "There is reservation conflict"
        end
      end
      hotel_block = Hotel::HotelBlock.new(date_range, rooms_array, discount_rate)
      add_hotel_block(hotel_block)
      return hotel_block
    end

    # A block can contain a maximum of 5 rooms

  end
end