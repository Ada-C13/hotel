require 'time'

require_relative 'room'
require_relative 'reservation'

module Hotel
  class ReservationManager
    attr_reader :rooms, :reservations

    def initialize(room_count)
      @rooms = generate_rooms(room_count)
      @reservations = nil
    end

    def new_reservation(dates)
    end


    private 

    def generate_rooms(room_count)
      rooms = []
      room_count.times do |num|
        rooms << {:room_id => (num+1).to_s}
      end
      return rooms
    end
  end
end