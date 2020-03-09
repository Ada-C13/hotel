module Hotel
  class Reservation
    attr_reader :date_range, :id, :room_number, :nights, :cost, :hotel_block

    attr_accessor :total_cost, :available

    def initialize(date_range, id = 0, room_number = 0, cost = 0, hotel_block = nil, available = nil)
      @date_range = date_range
      @id = id
      @cost = cost
      @nights = date_range.total_nights
      @total_cost = calculate_cost()
      @room_number = room_number
      @hotel_block = hotel_block || false
      @available = available || false
    end

    def calculate_cost()
      return @cost * @nights
    end

  end
end