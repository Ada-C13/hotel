module Hotel
  class RoomBlock
    attr_reader :name, :start_date, :end_date, :discount

    def initialize(name, start_date, end_date, discount)
      @name = name
      @start_date = Date.parse(start_date)
      @end_date = Date.parse(end_date)
      @discount = discount / 100.0

      # Check for requirementsand raise error if not met
      raise ArgumentError.new("The end date cannot be before the start date") if @start_date >= @end_date
    end
  end
end