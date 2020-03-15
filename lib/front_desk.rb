require_relative "date_range"
require_relative "room"
require_relative "reservation"

module Hotel 
  class FrontDesk

    attr_accessor :rooms, :reservations 

    def initialize(rooms: [], reservations: [])
      # set up 20 rooms 
      rooms = []
      rooms_in_hotel = 20 
      room_num = 1
      rooms_in_hotel.times do 
        rooms << Room.new(number: room_num) 
        room_num +=1 
      end 

      @rooms = rooms 
      @reservations = reservations
    end  
    
    # prints the list of the rooms in the hotel 
    def all_rooms
      @rooms.each do |room|
        puts "Room Number: #{room.number} | Nightly Rate: #{room.cost}"
      end 
    end 

    # accesses the list of reservations for a specific date
    def reservations_by_date(date_query)
      res_list = []
      @reservations.each do |res|
        if res.range.include?(date_query)
          res_list << res
        end
      end 
      return res_list 
    end 

    # accesses the list of reservations for a specified room and date range
    def reservations_by_room_and_range(room_num_query, range_query)
      return @reservations.find_all { |res| res.room_num == room_num_query && res.range.overlap?(range_query) }
    end 

    # accesses the list of rooms that are not reserved for a given date range
    def available_rooms(range_query)
      all_rooms = @rooms.map {|room| room.number}

      conflicting_reservations = @reservations.find_all { |res| res.range.overlap?(range_query) == true }
      occupied_rooms = conflicting_reservations.map {|res| res.room_num}
      occupied_rooms = occupied_rooms.uniq

      available_rooms = all_rooms - occupied_rooms 

      return available_rooms
    end 

    # helper method that adds to @reservations array 
    def update_reservations_list(reservation)
      @reservations << reservation
    end

    # makes a reservation of a room for a given date range and this chosen room will not be part of any other reservation overlapping that date range
    def reserve_room(start_date, end_date)
      requested_range = DateRange.new(start_date: start_date, end_date: end_date)
      reservable_rooms = available_rooms(requested_range)
      chosen_room = nil

      # pick first room in list of open rooms
      if reservable_rooms.length == 0
        raise ArgumentError.new("There are no open rooms available between the dates #{start_date} and #{end_date}. Please try another date range.")
      else 
        chosen_room = reservable_rooms.first 
      end 

      # create a unique id 
      if @reservations.length == 0 
        new_res_id = 1
      else 
        new_res_id = @reservations.last.id + 1
      end 

      # create a new reservation 
      new_reservation = Hotel::Reservation.new(id: new_res_id, room_num: chosen_room, start_date: start_date, end_date: end_date)

      # update @reservations 
      update_reservations_list(new_reservation)
    end
    
  end
end  