module Hotel
  class Reservation

    attr_reader :room_number, :rate, :date_range, :start_date, :end_date

    def initialize(start_date, end_date, room_number, rate = 200)
      @start_date = start_date
      @end_date = end_date
      @date_range = DateRange.new(start_date, end_date)
      @room_number = room_number 
      @rate = rate
    end

    # calculates the total of each reservation
    def cost
      total_cost = @date_range.nights.to_i * rate
      return total_cost
    end
  end
end
