require_relative 'date_range'

module Hotel
  class Reservation
    attr_reader :id, :start_date, :end_date, :date_range, :room_id, :block
    attr_accessor :cost

    @@next_id = 1

    def initialize(date_range, room_id, cost = 200.00)  
      @date_range = date_range
      @start_date = date_range.start_date
      @end_date = date_range.end_date
    
      @room_id = room_id
      @cost = cost

      @id = @@next_id
      @@next_id += 1
      @block = -1   
    end

    def get_total_price
      total_price = date_range.count_nights * cost
      return total_price
    end
  end
end
