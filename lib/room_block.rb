module Hotel
  class RoomBlock
    attr_reader :name, :start_date, :end_date, :discount, :block_id

    def initialize(name, start_date, end_date, discount, block_id)
      @name = name
      @start_date = Date.parse(start_date)
      @end_date = Date.parse(end_date)
      @discount = discount / 100.0
      @block_id = block_id

      # Check for requirements and raise error if not met for dates
      raise ArgumentError.new("The end date cannot be before the start date") if @start_date >= @end_date
      # Check for requirements and raise error if not met for room's block
      raise ArgumentError.new("Invalid amount of rooms for block") if block_id <= 0 || block_id > 5
    end
  end
end