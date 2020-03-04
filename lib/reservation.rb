module Hotel
  class Reservation
    attr_reader :room, :start_date, :end_date
    attr_accessor :cost

    def initialize(start_date:, end_date:, room:, cost: 200)
      @room = room
      @start_date = start_date
      @end_date = end_date
  
      @cost = cost
      
    end


    # User: I can get the total cost for a given reservation
    def total_cost
      room_rate = 200
      @cost = (@end_date - @start_date).to_i * room_rate
      return @cost
    end
  end
end
