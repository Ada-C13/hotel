module Hotel
  class Reservation
    # Feel free to change this method signature as needed. Make sure to update the tests!
    def initialize(start_date, end_date, room)
      @start_date = start_date
      @end_date = end_date
    end

    def cost
      return 3
    end
  end
end