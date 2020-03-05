module Hotel
  class Reservation
    attr_reader :room
    attr_accessor :start_date, :end_date

    def initialize(start_date:, end_date:, room:)
      @room = room
      @start_date = start_date
      @end_date = end_date
  

      # User: I want an exception raised when an invalid date range is provided, so that I can't make a reservation for an invalid date range
      if @end_date < @start_date || @start_date == @end_date
        raise ArgumentError.new("Your check-out date must be after your check-in.")
      end
      
    end

    # calculate the number of nights for a reservation (end date is not a night)
    def nights
      num_nights = @end_date - @start_date
      return num_nights.to_i
    end

    # User: I can get the total cost for a given reservation
    def cost
      room_rate = 200
      cost = nights * room_rate
      return cost
    end
  end
end
