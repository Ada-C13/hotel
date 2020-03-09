module Hotel
  class HotelReception
    attr_accessor :rooms, :reservations, :blocks

    def initialize
      @rooms = []
      20.times do |i|
        @rooms << Hotel::Room.new(i + 1, 200)
      end
      @reservations = []
      @blocks = []
    end

    def find_reservation(id)
      return reservations.find { |res| res.id == id }
    end

    def available_rooms(check_in_time, check_out_time)
      my_dates = Hotel::DateRange.new(check_in_time, check_out_time)
      #get the reservations that overlap with these dates
      unavail = reservations.select { |res| res.dates.overlap?(my_dates) }
      #get the room object for that reservation
      unavail.map! { |res| res.room }
      #get blocks that overlap with these dates
      unavail_in_block = blocks.select { |block| block.dates.overlap?(my_dates) }
      #map this array of blocks to the arrays of rooms
      unavail_in_block.map! { |block| block.rooms }
      #convert the array of arrays to a single array
      unavail_in_block.flatten!

      avail_rooms = rooms.difference(unavail)

      return avail_rooms.difference(unavail_in_block)
    end
    
    def list_reservations(date:, room_id: nil)
      res_by_date = reservations.select { |res| res.dates.include?(date) }
      if room_id
        res_by_room = reservations.select { |res| res.room.id == room_id }
        res_by_room.map! { |res| res.room.id }
        return res_by_date.difference(res_by_room)
      else
        return res_by_date
      end
    end

    def make_reservation(check_in_time, check_out_time)
      room = available_rooms(check_in_time, check_out_time).first
      if room
        @reservations << Hotel::Reservation.new(check_in_time, check_out_time, room)
        return reservations.last
      else
        raise ArgumentError, "There are no rooms available on that date."
      end
    end

    def make_block(my_rooms, check_in_time, check_out_time, discount: 0.2)
      avail = available_rooms(check_in_time, check_out_time)
      all_rooms = my_rooms.select { |room| avail.include?(room) }

      if all_rooms.length == my_rooms.length
        @blocks << Hotel::HotelBlock.new(all_rooms, check_in_time, check_out_time, discount: discount)
        return @blocks.last
      else
        raise ArgumentError, "It looks like those rooms aren't all available right now. #{my_rooms}"
      end
    end
  end
end