require 'date'

module Hotel
  class Room
    attr_reader :room_number
    attr_accessor :cost, :reservations, :block_status, :availability
    
    def initialize(room_number:, cost:, reservations: nil)
      @room_number = room_number

      raise ArgumentError.new("There are only 20 rooms") if room_number < 1 || room_number > 20

      @cost = 200
      @reservations = reservations || []
      @block_status = :in_block || :not_in_block
      @availability = :available || :unavailable

    end

    def add_room_reservation(reservation)
      @reservations << reservation
    end

  end
end
