module Hotel
  class Reservation
    attr_reader :id, :room
    attr_accessor :start_date, :end_date, :cost

    # ? what's the difference between "variable," as shown below, and "variable:,"
    def initialize(id, start_date, end_date, room, cost = 200)
      @id = id
      @start_date = start_date
      @end_date = end_date
      @room = room
      @cost = cost

      # User: I want exception raised when an invalid date range is provided, so that I can't make a reservation for an invalid date range
      # TODO add date validation & date range validation
    end


    # User: I can get the total cost for a given reservation
  end
end
