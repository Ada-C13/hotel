module Hotel
  class Reservation
    attr_reader :room
    attr_accessor :start_date, :end_date

    def initialize(start_date:, end_date:, room:)
      @room = room
      @start_date = start_date
      @end_date = end_date
  
    end



    # User: I can get the total cost for a given reservation
    def cost
      nights = (end_date - start_date).to_i
      room_rate = 200
      cost = nights * room_rate
      return cost
    end
  end
end
