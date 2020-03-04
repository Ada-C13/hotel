module Hotel
  class FrontDesk
    attr_reader :rooms, :reservations

    def initialize()
      @rooms = Array.new(20) { |room| room + 1 }
      @reservations = []
    end

    def select_available_room(start_date, end_date)
      requested_date_range = Hotel::DateRange.new(start_date, end_date)
      overlap = false

      @rooms.each do |room|
        current_room_reservations = @reservations.select do |reservation|
          reservation.room == room
        end

        if current_room_reservations == []
          return room
        end

        current_room_reservations.each do |reservation|
          if reservation.date_range.overlap?(requested_date_range)
            overlap = true
          end
        end

        if !overlap
          return room
        end
      end

      raise ArgumentError.new("No room is available for the requested dates: #{start_date} to #{end_date}")
    end
  end
end
