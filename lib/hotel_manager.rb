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
      # start_date and end_date should be instances of class Date
        # covered by having Reservation inherit from DateRange
      # need to keep in mind implementation of room choice


      #TODO
      # room chosen is based on the method! not by the user! (see README.md)
      # if nil, default will then redirect to be first available room
      # add reservation instance to @rooms array based off of room attribute
      # add date instance to @rooms array
      reserved_room = Hotel::DateRange.new(start_date, end_date)
      return Reservation.new(reserved_room.start_date, reserved_room.end_date)
    end

    def reservations(date)
      reservation_list = []

      @rooms.each do |room| # O(20)
        room.each_value do |reservation| # O(20)
          reservation.each do |reservation_instance| # O(n)
            if date.between?(reservation_instance.start_date, reservation_instance.end_date)
              reservation_list << reservation_instance
            end
          end
        end
      end

      return reservation_list
    end

    # lookup reservations by room and date
    def reservations_by_room(room, date)
    # to lookup by room use key
    # use reservations(date) method to get specific date range
    valid_room_inputs = []
    20.times do |i|
      valid_room_inputs << ("room#{i+1}").to_sym
    end

    unless valid_room_inputs.include?(room)
      raise ArgumentError.new("Not a valid room")
    end

    room_index = ((room.to_s).match('[0-9]')[0]).to_i

    return []

    # room 1 - @rooms[0][:room1]
    # room 5 - @rooms[4][:room5]
    # use regex on room attribute, then turn into integer subtract 1 for the index to access



    end

    # Wave 2
    def available_rooms(start_date, end_date)
      # start_date and end_date should be instances of class Date
      # available_rooms = []
      # you'll return an array of keys which are the rooms
      # indicating the available rooms
      # use logic from reservations(date)
        # use unless date.between?(reserv.start date, enddate)
        # add the room# to the available rooms list
      return []
    end
  end
end
