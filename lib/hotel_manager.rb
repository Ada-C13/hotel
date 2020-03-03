require_relative 'reservation'
require_relative 'date_range'
require_relative 'room'

module Hotel 
  class HotelManager 
    attr_reader :rooms, :reservations 

    def initialize(rooms = [])
      20.times do |i| 
        rooms << Hotel::Room.new(i + 1)
      end 

      @rooms = rooms
      @reservations = []
    end 


    def available_room(date_range)
      date_range.valid_dates?

      return @rooms.find { |room| room.vacancy == true }
    end


    def make_reservation(date_range) #Date.new(start_date, end_date)
      date_range.valid_dates?

      room = self.available_room(date_range)
      reservation = Hotel::Reservation.new(date_range, room)

      # Invoke the method
      reservation.room.change_vacancy

      # Add reservation
      @reservations << reservation

      return reservation
    end 


    def find_reservations_by_date(date_range)
      return @reservations.filter { |reservation|
        reservation.date_range == date_range } 
    end 
  end 
end 