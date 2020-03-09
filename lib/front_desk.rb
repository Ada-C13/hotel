require_relative "date_range"
require_relative "room"
require_relative "reservation"

module Hotel 
  class FrontDesk

    attr_accessor :rooms, :reservations 
    def initialize(rooms: [], reservations: [])
      @rooms = rooms
      @reservations = reservations
    end  
    
    def update_room_list(room)
      @rooms << room 
    end 

    def create_rooms
      rooms_in_hotel = 20 
      room_num = 1

      rooms_in_hotel.times do 
        update_room_list( Room.new(number: room_num) ) 
        room_num +=1 
      end 
    end 

    def all_rooms
      @rooms.each do |room|
        puts room 
      end 
    end 

    # find reservations in @reservations array with matching room_num, start_date, end_date 
    # returns: array of all reservation objects with matching room_num, start_date, and end_date
    # modifies: nothing
    def reservations_by_room_and_range(room_num, start_date, end_date)
      # in @reservations, print all reservations with matching room_num, find matching start_date, find matching end_date
    end 

    # find a reservation in @reservations array with matching date
    # returns: array of all reservation objects where matching date is included in the reservation's date range
    # modifies: nothing
    def reservations_by_date(date)
    end 

    # find a room in @rooms array where the room's reservation's does not match the date range 
    # returns: array of rooms where the supplied date range is NOT overlapping with any other of the room's reservation's date range
    # modifies: nothing
    def available_rooms(start_date, end_date)
    end 

    # create helper method that adds to @reservations array 
    # returns: nothing 
    # modifies: @reservations 
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
    def reserve_rooms(start_date, end_date)
    end



  end
end  