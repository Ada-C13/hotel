require 'date'

module Hotel
  class Room
    attr_reader :room_number, :rooms
    attr_accessor :cost, :status, :reservations
    
    def initialize(room_number:, cost:, status: :available, reservations: nil)
      @room_number = room_number
      @cost = 200
      
      if status == :available || status == :unavailable
        @status = status
      else  
        raise ArgumentError.new("Room status must be availble or unavailable")
      end

      @reservations = []

    end


  end
end
