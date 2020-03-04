module Hotel
  class Reservation < DateRange
    attr_reader :room_num, :nights, :total_cost

    def initialize(arrive, depart)
      super(arrive, depart)
      @room_num = 1
      @nights = 2
      @total_cost = 0
    end


    def find_available_room
      return rand(1..20)
    end

    def self.total_cost

    end
  end
end