require_relative 'date_range'
module Hotel
  class Reservation < DateRange
    attr_reader :cost, :room
    def initialize(start_date, end_date, room)
      super(start_date, end_date)
      # TODO figure out how to use a nightly cost constant
      # across the module
      @room = room
      @cost = self.num_nights * 200
    end
  end
end
