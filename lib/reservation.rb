
module Hotel
  class Reservation
    attr_reader :id, :room, :start_date, :end_date

    def initialize(id, room, start_date, end_date)
      @id = id
      @room = room
      @start_date = Date.parse(start_date)
      @end_date = Date.parse(end_date)
      
      # Check for requirementsand raise error if not met
      raise ArgumentError.new("The end date cannot be before the start date") if @start_date >= @end_date
    end
   
    # Calculate total reservation cost based on nightly rate
    def total_cost
      return ((end_date - start_date) * room.nightly_rate)
    end
  end
end