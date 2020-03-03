module Hotel
  class Reservation
    # attr_reader :id
    # ! should I add a reservation id?
    attr_accessor :start_date, :end_date, :room, :cost


    # ? what's the difference between "variable," as shown below, and "variable:,"
    def initialize(start_date, end_date, room, cost = 200)
      @start_date = start_date
      @end_date = end_date
      @room = room
      @cost = cost
    end

  end
end