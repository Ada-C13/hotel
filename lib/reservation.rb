require_relative 'date_range'
module Hotel
  class Reservation
    attr_accessor :start_date, :end_date, :room, :room_rate
    # Feel free to change this method signature as needed. Make sure to update the tests!
    def initialize(start_date, end_date, room_rate = 200)
      @start_date = start_date
      @end_date = end_date
      @room_rate = room_rate
    end

    def cost
      return DateRange.new(start_date, end_date).length_of_stay * @room_rate
    end
  end
end