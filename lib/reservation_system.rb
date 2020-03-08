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
    def find_reservations_by_date(aDate, aRoom_number = nil) 
      if aDate.class != Date
        raise ArgumentError.new("Invalid date, must be Date.")
      end

      if (aRoom_number != nil) && (aRoom_number.class != Integer)
        raise ArgumentError.new("Invalid, room number must be nil or an Integer.")
      end 

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

    # find room based on room number
    # input: aRoom_number (int)
    # returns Room
    def find_room(aRoom_number)
      if aRoom_number.class != Integer
        raise ArgumentError.new("Invalid, room number needs to be an Integer")
      end

      found_room = nil
      @rooms.each do |room|
        if room.room_number == aRoom_number
          return room
        end
      end
      return found_room
    end
    #****************************************************************

    #Helper method to: def reserve_room(aReservation)
    # Find reservations based on Room
    # input : aRoom object of class (Room)
    # returns found_reservations [Reservation]
    def find_reservations_by_room(aRoom)
      if aRoom.class != Hotel::Room
        raise ArgumentError.new("Invalid input of a Room.")
      end

      found_reservations = []
      #loop through reservations
      @reservations.each do |reservation|
      #check if reservation room_number matches the Rooms room_number
      #check if reservation is confirmed
        if reservation.room_number != nil && reservation.room_number.class == Integer && (reservation.room_number == aRoom.room_number) && (reservation.status == :confirmed)
          #if matches, add to reservations[]
          found_reservations.push(reservation)
        end
      end
      return found_reservations
    end

    #****************************************************************

    # Reserves a room based on reservation request
    # aReservationRequest (Reservation) - the reservation request (by reference, modifying reservation will modify original)
    # returns aReservationRequest with its status updated to :confirmed or :denied
    def reserve_room(aReservationRequest)
      if aReservationRequest.class != Hotel::Reservation
        raise ArgumentError.new("Invalid input of a Reservation Request.")
      end
      #loop through rooms
      @rooms.each do |room|
      #check if room is available for reservation dates
      #find reservations for this room (write method elsewhere then use here)
        confirmed_reservations = self.find_reservations_by_room(room)
        #aReservation overalapping with found_reservation[]
        areOverlapped = aReservationRequest.are_reservations_overlapped(confirmed_reservations)
        # check if overlaps
        if !areOverlapped 
          # Not overlap, reserve room!
          #change reservation status to confirmed
          aReservationRequest.status = :confirmed
          # Set the reservation's room and room_number
          aReservationRequest.room = room #by reference, modifying room
          aReservationRequest.room_number = room.room_number #by reference, modifying room_number
          #add to reservation to confirmed reservations
          @reservations.push(aReservationRequest)
          return aReservationRequest
        end
        # else go to next room
      end
      # no rooms available
      # change status to denied
      aReservationRequest.status = :denied
      raise Exception.new "Reservation request is overlapping with confirmed reservations."
      # return aReservationRequest - raising the exception to meet user story reqs
    end
    #****************************************************************
    #rooms available based on aReservationRequest
    #input:aReservationRequest ( Reservation )
    #return: rooms_available ( [Room] )

    def rooms_available(aReservationRequest)
      if aReservationRequest.class != Hotel::Reservation
        raise ArgumentError.new("Invalid input of a Reservation Request.")
      end

      rooms_available = []
      #loop through the array of rooms
      @rooms.each do |room|
        #get reservations by room 
        confirmed_reservations = self.find_reservations_by_room(room)
        #check if reservationrequest overlaps with confirmed reservations (are_res_overlapped)
        if aReservationRequest.are_reservations_overlapped(confirmed_reservations) 
          next #go to next room
        else
          # add to rooms_available []
          rooms_available.push(room) 
        end
      end
      return rooms_available
    end

    #****************************************************************
  end # Class
end # Module

  #Wave 1
  # test = Hotel::ReservationSystem.new
  # #Access list of all the rooms in the hotel
  # puts test.rooms
  # #Access list of reservations for specified room and a given date range
  # date = Date.today
  # res = Hotel::ReservationSystem.getReservations(date, 5)

  # hotelsystem = Hotel::ReservationSystem.new
  # # puts hotelsystem.rooms.class
  # # puts hotelsystem.reservations.class
  # # room = hotelsystem.find_room(7)

  # date1 = Date.parse("2020-10-04")
  # res1 = Hotel::Reservation.new(1, date1, 20)
  # puts res1.status
  # puts Hotel::Reservation.class
  # rooms = hotelsystem.rooms_available(res1)
  # puts rooms.length
  # hotelsystem.reserve_room(res1) 
  # #puts confirmed.status

  # puts res1.status

  # rooms = hotelsystem.rooms_available(res1)
  # puts rooms.length
  # rooms.each do |room|
  # #  puts room.room_number
  # end
  # puts "here"
  # this_res = hotelsystem.find_reservations_by_room(room)


  # this_res.each do |res|
  #   puts res.status
  #   puts res.number_of_days
  #   puts res.room_number
  # end

  # res = Hotel::Reservation.new(1, Date.parse("2020-10-29"), 7, "confirmed", nil, 1)
  # puts hotelsystem.reserve_room(res)

  # found_res = hotelsystem.find_reservations_by_date(Date.parse("2020-10-29"))
  # found_res.each do |res|
  #   puts res.room_number
  #   puts res.check_in
  #   puts res.check_out
  # end


