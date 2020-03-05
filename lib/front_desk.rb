require_relative 'room'
require_relative 'reservation'

module HotelBooking
  class FrontDesk
    attr_reader :rooms, :reservations
    def initialize
    @rooms = self.create_rooms
    @reservations = []
    end

    def create_rooms
      created_room = []
      (1..20).each do |x| 
        created_room << Room.new(number: x)
      end 
      return created_room
    end

    # def available_rooms(start_date, end_date)
    #   # start_date and end_date should be instances of class Date
    #   return []
    # end

    def make_reservation(date_range)
      #does this need to be self.all_rooms[1]
      available_room = @rooms[1]
      reservation = Reservation.new(date_range: date_range, room: available_room)
      @reservations << reservation
      return reservation
    end
  
    def room_reservations(room, test_range)
      # self.all_rooms
      room_reservations = []
      @reservations.each do |reservation|
        if reservation.room == room 
          if reservation.date_range.overlap?(test_range)
            room_reservations << reservation
          end
        end
      end
      return room_reservations
    end

    def date_reservations(date)
      date_reservations = []
      @reservations.each do |reservation|
        if reservation.date_range.include?(date)
            date_reservations << reservation
          end
      end
      return date_reservations
    end
   
  end

end
