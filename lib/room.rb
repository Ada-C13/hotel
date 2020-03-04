require_relative 'reservation'

module Hotel
  class Room
    attr_reader :room_id, :cost, :bookings

    def initialize(room_id, cost = 200.00, bookings = nil)
      raise ArgumentError if !room_id.is_a? Integer
      raise ArgumentError if room_id < 1
      @room_id = room_id
      @cost = cost
      @bookings = bookings || []
    end

    def add_booking_to_room(new_reservation)
      @bookings << new_reservation
    end


    # def self.all


    # def find(date_range)
  

  end
end
