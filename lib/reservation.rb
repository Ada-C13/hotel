require_relative 'date_range'
module Hotel
  class Reservation < DateRange
    attr_reader :cost, :room
    def initialize(start_date, end_date, room, rate= 200)
      super(start_date, end_date)
      @room = room
      @cost = self.num_nights * rate
    end
  end
end
