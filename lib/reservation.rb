require_relative 'date_range'

module Hotel
  class Reservation < DateRange
    attr_reader :arrive, :depart, :room_id

    def initialize(arrive, depart)
      super(arrive, depart)
      @room_id = find_room
      @nights = Hotel::DateRange.nights(arrive, depart)
      @total_cost = 
    end


    def self.find_room
      
    end

    def self.total_cost

    end
  end
end