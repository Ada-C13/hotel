require 'time'
require 'awesome_print'

require_relative 'room'
require_relative 'reservation'


module Hotel
  class ReservationSystem
    attr_reader :rooms, :reservations
        
    def initialize()
      @rooms = Room.load_all_rooms()
      @reservations = Reservation.load_all_reservations()
    end
    #****************************************************************

    #Search thru reservations and find ones that match room and date
    # aRoom_number (string)
    # date (Date)
    # returns Array of Reservations
    def find_reservations(aDate, aRoom_number = nil) 
      reservations = []
      # search through reservations
      @reservations.each do |reservation|
        # check if requested aRoom_number is same as reservation's room id
        # and requested date is within the reservation's  checkin to checkout timeframe
        if aRoom_number != nil
          if (aRoom_number == reservation.room_number) && (reservation.is_within_stay(aDate))
            # if both are true, save the reservation  
              reservations.push(reservation)
          end
        else
          #checking rooms with this date only
          if (reservation.is_within_stay(aDate))
              reservations.push(reservation)
          end
        end
      end
      return reservations
    end
    #****************************************************************

    # find room based on id
    # returns Room
    def find_room(aRoom_number)
      found_room = nil
      @rooms.each do |room|
        if room.room_number == aRoom_number
          return room
        end
      end
      return found_room
    end
    #****************************************************************

    #TODO
    # Reserves a room based on reservation request
    # aReservation (Reservation) - the reservation request
    # returns aReservation with its status updated to :confirmed or :denied
    def reserve_room(aReservation)
      #loop through rooms
      @rooms.each do |room|
      #check if room is available for reservation dates
        if (room.status == :confirmed) || (room.status == :denied)
        end
      end
      return aReservation
    end
    #****************************************************************
    #START HERE
    
  end # Class
end # Module



    #unavailable rooms

    #available rooms
    
    #reserve room

    #cancel room

    #reservation for given date

    #reservation for date range

    #validate room

    #assign room

    #validate date again?



  # #Wave 1
  # test = Hotel::ReservationSystem.new
  # #Access list of all the rooms in the hotel
  # puts test.rooms
  # #Access list of reservations for specified room and a given date range
  # date = Date.today
  # res = Hotel::ReservationSystem.getReservations(date, 5)

  hotelsystem = Hotel::ReservationSystem.new
  puts hotelsystem.rooms.class
  puts hotelsystem.reservations.class

  res = Hotel::Reservation.new(1, Date.parse("2020-10-29"), 7, "confirmed", 1, 1)
  puts hotelsystem.reserve_room(res)

  # found_res = hotelsystem.find_reservations(Date.parse("2020-10-29"))
  # found_res.each do |res|
  #   puts res.room_number
  #   puts res.check_in
  #   puts res.check_out
  # end


