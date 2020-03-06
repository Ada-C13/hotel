
module Hotel
  class Reservation
    attr_reader :id, :room, :start_date, :end_date

    def initialize(id, room, start_date, end_date)
      @id = id
      @room = room
      @start_date = Date.parse(start_date)
      @end_date = Date.parse(end_date)

      # Check end date is after start date
      ##make unit test for edge case of 3/1/2020 - 3/12/2020
      if @start_date >= @end_date
        raise ArgumentError.new("The end date cannot be before the start date")
      end
    end
   
    # Calculate total reservation cost based on nightly rate
    def total_cost
      return ((end_date - start_date) * room.nightly_rate)
    end
  end
end