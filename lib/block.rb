module Hotel
  class Block < DateRange
    def initialize(start_date, end_date, rooms, rate)
      super(start_date, end_date)
      # range necessary for class state?, or local var better?
      @range = DateRange.new(start_date, end_date)
      if rooms.any? { |room| !(room.available?(@range))}
        raise ArgumentError.new("Room #{room.id} is not available at given date range.")
      end
      @rate = rate
      @reservations = []
      @rooms = rooms
      @rooms.each do |room|
        room.add(self)
      end

    end

    def reserve(room)
    end

    def available_rooms
    end


  end
end