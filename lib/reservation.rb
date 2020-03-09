
module Hotel
  class Reservation
    attr_reader :id, :room, :start_date, :end_date, :discount, :status

    def initialize(id, room, start_date, end_date, discount = nil, status = :CONFIRMED)
      @id = id
      @room = room
      @start_date = Date.parse(start_date)
      @end_date = Date.parse(end_date)
      @discount = discount
      @status = status

      # Check for requirementsand raise error if not met
      raise ArgumentError.new("The end date cannot be before the start date") if @start_date >= @end_date
    end

    # Calculate total reservation cost based on nightly rate with discount if applied
    def total_cost
      nights_cost = ((end_date - start_date) * room.nightly_rate)
      discount ? nights_cost - (nights_cost * discount) : nights_cost
    end
  end
end