module Hotel
  class ReservationDesk
  # Responcibility: to organize reservations across hotel
    attr_reader :room_num, :rooms, :reservations, :blocks

    def initialize(room_num: 20)
      @room_num = room_num
      @rooms = make_rooms
      @blocks = {}
    end

    def find_room_by_id(id)
      rooms.find {|room| room.id == id}
    end

    def find_reservations(room_id: nil , start_date: , end_date: )
      date_range = DateRange.new(start_date: start_date, end_date: end_date)

      if room_id 
        room = rooms.find { |room| room.id == room_id}
        return nil if room == nil
        reservations = room.select_reservations(date_range)
      else
        reservations = []
        rooms.each do |room|
          room_reservations = room.select_reservations(date_range)
          reservations += room_reservations
        end
      end

      return reservations
    end

    def find_available_rooms(start_date:, end_date:)
      #TODO: efficient date checking
      available_rooms = []
      rooms.each do |room|
        available_rooms << room if room.available?(start_date: start_date, end_date: end_date)
      end
      return available_rooms.empty? ? nil : available_rooms
    end

    def make_reservation(room_id: nil, start_date:, end_date:)
      if room_id 
        room = find_room_by_id(room_id)
        raise ArgumentError.new("Invalid room ID.") if room == nil
      else
        room = find_available_rooms(start_date: start_date, end_date: end_date)[0]
        raise StandardError.new("No rooms available for these dates.") if room == nil
      end
      room.reserve(start_date: start_date, end_date: end_date)
    end

    def make_block(room_ids: nil, start_date:, end_date:)
      #TODO: nil scenario
      raise ArgumentError.new("Blocks can't contain more than 5 rooms.") if room_ids.length > 5
      block_id = generate_block_id
      blocks[block_id] = []
      room_ids.each do |id|
        room = find_room_by_id(id)
        raise ArgumentError.new("Invalid room ID.") if room == nil
        room.reserve(start_date: start_date, end_date: end_date, block: block_id)
        blocks[block_id] << id
      end
    end

    private
    def make_rooms
      rooms = []
      room_num.times do |i|
        rooms << Room.new(i+1)
      end
      return rooms
    end

    def generate_block_id
      blocks.length + 1
    end
  end
end














# def new_reservation(room_id: nil, start_date: , end_date: )
#   unless room_id == nil || rooms.find {|room| room.id == room_id}
#     raise ArgumentError.new("Invalid room ID.")
#   end
#   #TODO: Check availability or possibly remove?

#   if room_id == nil
#     room_id = find_available_rooms(start_date: start_date, end_date: end_date).first.id
#   end
#   Reservation.new(room_id: room_id, start_date: start_date, end_date: end_date)
# end

# # TODO: should be combined with new_reservation? Maybe a larger method to call both of them?
# def add_reservation(new_reservation)
#   room = find_room_by_id(new_reservation.room_id)
#   room.reservations << new_reservation
# end


# def find_reservations(room_id: nil , start_date: nil, end_date: nil)
    #   room = rooms.find { |room| room.id == room_id}
    #   return nil if room == nil

    #   return room.reservations if (start_date == nil && end_date == nil)

    #   if end_date == nil
    #     start_date = Date.parse(start_date)
    #     reservations = room.reservations.select { |reservation| 
    #       start_date < reservation.end_date
    #     }
    #   elsif start_date == nil
    #     end_date = Date.parse(end_date)
    #     reservations = room.reservations.select { |reservation| 
    #       end_date > reservation.start_date 
    #     }
    #   else
    #     start_date = Date.parse(start_date)
    #     end_date = Date.parse(end_date)
    #     # date_range = (start_date..end_date)
    #     reservations = room.reservations.select { |reservation| 
    #       start_date < reservation.end_date && end_date > reservation.start_date 
    #     }
    #   end
    #   return reservations
      
    #   #TODO: add date_range class and refactor
    # end


       # def find_available_room(start_date: , end_date:)
    #   #TODO: efficient date checking

    #   date_range = DateRange.new(start_date: start_date, end_date: end_date)
      
    #   rooms.each do |room|
    #     switch = 0
    #     room.reservations.each do |reservation|
    #       if reservation.date_range.overlap?(date_range)
    #         switch = 1
    #         break
    #       end
    #     end
    #     return room if switch == 0
    #   end
    #   return nil
    # end