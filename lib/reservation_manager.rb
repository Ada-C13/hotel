require 'time'

require_relative 'room'
require_relative 'reservation'

module Hotel
  class ReservationManager
    attr_reader :rooms, :reservations

    def initialize(room_count)
      @rooms = generate_rooms(room_count)
      @reservations = []
    end

    def create_reservation(type, range, guest)
      range = DateRange.new(Date.new, Date.new+2)
      @reservations << Reservation.new("single", range, [{:room => @rooms.sample, :guest => guest}])
    end

    private 

    def generate_rooms(room_count)
      rooms = []
      room_count.times do |num|
        rooms << Room.new(num+1)
      end
      return rooms
    end
  end
end