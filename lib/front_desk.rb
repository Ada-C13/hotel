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

    def make_reservation(start_date, end_date)
      if !(start_date.is_a? Date) || !(end_date.is_a? Date)
        raise ArgumentError.new("Invalid date format. start_date and end_date should be of type Date")
      end
  
      selected_room = select_available_room(start_date, end_date)
      date_range = Hotel::DateRange.new(start_date, end_date)
      @reservations << Hotel::Reservation.new(date_range, selected_room)
    end

    def reservation_by_room(room)
      if !room.is_a? Integer
        raise ArgumentError.new("Invalid argument #{rooms}. Should be of type Integer.")
      end

      return @reservations.select do |reservation|
        reservation.room == room
      end
    end

    def reservation_by_start_date(date)
      if !date.is_a? Date
        raise ArgumentError.new("Invalid argument #{date}. Should be of type Date.")
      end

      return @reservations.select do |reservation|
        reservation.date_range.start_date == date
      end
    end

    def reservations_by_date_range(start_date, end_date)
      asked_date_range = Hotel::DateRange.new(start_date, end_date)

      return @reservations.select do |reservation|
        reservation.date_range.start_date == asked_date_range.start_date &&
        reservation.date_range.end_date == asked_date_range.end_date
      end
    end







  end
end
