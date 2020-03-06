require_relative 'room'
require_relative 'reservation'
require_relative 'date_range'

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

    def available_rooms(test_range)
      available_rooms = @rooms
      @reservations.each do |res|
        available_rooms.reject { |room| room == res.room } if res.date_range.overlap?(test_range)
      end
      

      # available_rooms = []
      # @rooms.each do |room|
      #   @reservations.each do |reservation| 
      #     room_res = reservation.room_reservations(room, date_range) 
      #     if room_res.lenght == 0
      #       available_rooms << room
      #     end
      #   end
      # end

      # tests get crazy when I do this
      # raise ArgumentError.new("No rooms available") if available_rooms.lenght == 0
      return available_rooms
    end

    def make_reservation(date_range)
      available_room = self.available_rooms(date_range).first
      reservation = Reservation.new(date_range: date_range, room: available_room)
      @reservations << reservation
      return reservation
    end

    def make_room_reservation(test_range, room)
      @reservations.each do |reservation|
        if reservation.room == room && !(reservation.date_range.overlap?(test_range))
          new_res = Reservation.new(date_range: test_range, room: room)
          @reservations << new_res
        end
      end
      return reservation
    end
  
    # change name to list....
    def room_reservations(room, test_range)
      # self.all_rooms
      room_reservations = []
      @reservations.each do |reservation|
        if reservation.room == room && reservation.date_range.overlap?(test_range)
          room_reservations << reservation
        end
      end
      return room_reservations
    end

    # change name to list....
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
