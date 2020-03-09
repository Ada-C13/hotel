module Hotel
  class RoomBlock
    attr_reader :name, :start_date, :end_date, :discount, :how_many_rooms, :list_rooms

    def initialize(name, start_date, end_date, discount, how_many_rooms, list_rooms)
      @name = name
      @start_date = Date.parse(start_date)
      @end_date = Date.parse(end_date)
      @discount = discount / 100.0
      @how_many_rooms = how_many_rooms
      @list_rooms = list_rooms
    
      # Check for requirements and raise error if not met for dates
      raise ArgumentError.new("The end date cannot be before the start date") if @start_date >= @end_date
      # Check for requirements and raise error if block of rooms does not pass
      raise ArgumentError.new("Invalid amount of rooms for block") if how_many_rooms <= 0 || how_many_rooms > 5
    end

    # Set as empty array if no instance variable was instantiated
    def reservations
      @reservations ||= []
    end
  end
end