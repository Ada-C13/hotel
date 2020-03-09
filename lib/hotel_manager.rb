require_relative 'date_range'

module Hotel
  class HotelController
    # Wave 1
    attr_reader :rooms
    def rooms
      @rooms = []
      20.times do |i|
        @rooms << {(("room#{i+1}").to_sym) => []}
      end

      return @rooms
    end

    def reserve_room(start_date, end_date)
      available_rooms = available_rooms(start_date, end_date)

      if available_rooms.empty?
        raise ArgumentError.new, "No available rooms for this date range."
      else
         # at random choose from available rooms
        chosen_room = (available_rooms.sample.to_sym)
        room_index = (((chosen_room.to_s).match('[0-9]')[0]).to_i) - 1

        # add reservation to master room list (@rooms)
        reserved_room = Hotel::DateRange.new(start_date, end_date)
        reserved = Hotel::Reservation.new(reserved_room.start_date, reserved_room.end_date)
        @rooms[room_index][chosen_room] << reserved
      end

      return @rooms
    end

    def reservations(date)
      reservation_list = []

      @rooms.each do |room|
        room.each_value do |reservation|
          reservation.each do |reservation_instance|
            if date.between?(reservation_instance.start_date, reservation_instance.end_date)
              reservation_list << reservation_instance
            end
          end
        end
      end

      return reservation_list
    end

    # method to lookup reservations by room and date
    def reservations_by_room(room, date)
      valid_room_inputs = []
      20.times do |i|
        valid_room_inputs << ("room#{i+1}").to_sym
      end

      unless valid_room_inputs.include?(room)
        raise ArgumentError.new("Not a valid room")
      end

      room_index = (((room.to_s).match('[0-9]')[0]).to_i) - 1
      reservation_list = []

      @rooms[room_index][room].each do |reservation_instance|
        if date.between?(reservation_instance.start_date, reservation_instance.end_date)
          reservation_list << reservation_instance
        end
      end

      return reservation_list
    end

    # Wave 2
    def available_rooms(start_date, end_date)
      unavailable_rooms = []
      available_rooms = @rooms.map { |room| (room.keys).join }

      test_range = Hotel::DateRange.new(start_date, end_date)

      @rooms.each do |room|
        room.each_value do |reservation|
          reservation.each do |reservation_instance|
            reservation_range = Hotel::DateRange.new(reservation_instance.start_date, reservation_instance.end_date)
            if reservation_range.overlap?(test_range) == true
              unavailable_rooms << (room.keys).join
            end
          end
        end
      end
       
      available_rooms = available_rooms - unavailable_rooms
      return available_rooms
    end
  end
end
