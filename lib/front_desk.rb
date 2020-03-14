require_relative "date_range"
require_relative "room"
require_relative "reservation"
require "pry"

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
    
    # accesses the list of the rooms in the hotel 
    def all_rooms
      @rooms.each do |room|
        puts "Room Number: #{room.number} | Nightly Rate: #{room.cost} | Reservation History: #{room.reservation_ids}"
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
      res_list = []
      res_list = @reservations.find_all { |res| res.room_num == room_num_query && res.range.overlap?(range_query) }
      return res_list
    end 

    # accesses the list of rooms that are not reserved for a given date range
    def available_rooms(range_query)
      res_list = []
      res_list = @reservations.find_all { |res| res.range.overlap?(range_query) == false }
      available_rooms_list = res_list.map {|res| res.room_num}
      return available_rooms_list
    end 

    # helper method that adds to @reservations array 
    def update_reservations_list(reservation)
      @reservations << reservation
    end

    # - create a new reservation object:  
    #   - with a room_id of an available room 
    #   - with a date range that does not conflict with exisiting reservation's date_range in @reservations 
    # - then add it to @reservations list 
    # - then add it to room's record of reservations
    # returns: nothing
    # modifies: @reservations & @rooms
    def reserve_room(start_date, end_date)
      requested_range = DateRange.new(start_date: start_date, end_date: end_date)
    end
  end
end  