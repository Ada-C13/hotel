require 'Date'
module Hotel
  class HotelController

    def initialize
      @reservation_array = []
    end

    # Wave 1
    def rooms 
      rooms = [1..20]
      return rooms    # You might want to replace this method with an attr_reader
    end

    def reserve_room(start_date, end_date, room)
      new_res = Reservation.new(start_date, end_date, room, nil) #is nil needed?
      @reservation_array << new_res
      return new_res
    end


    def reservations(date)
      if date.class == String
        date = Date.parse(date)
      end

      res_by_date = []

      @reservation_array.each do |res| 
        if date.between?(res.start_date,res.end_date)
          res_by_date << res
        end 
      end

      return res_by_date
    end

    
    def reservation_by_date_room(date,room_num)
      res_array = reservations(date)
      room_res_array = []

      res_array.each do |res|
        if res.room == room_num
          room_res_array << res
        end 
      end
      return room_res_array
    end

    def available_rooms(start_date, end_date)
      start_date = DateRange.new(start_date, end_date).start_date
      end_date = DateRange.new(start_date, end_date).end_date

      range_length = (end_date - start_date) - 1

      not_available = []

      range_length.to_i.times do |i|
        res_by_date_array = reservations(start_date + i)

        res_by_date_array.each do |res|
          not_available << res.room
        end
      end

      rooms_available_for_range = []

      20.times do |i|
        if not_available.include?(i+1)
          nil
        else
          rooms_available_for_range << (i + 1)
        end
      end

      if rooms_available_for_range.length > 0
       return rooms_available_for_range
      else 
      raise ArgumentError, "There are no room available for that date range :("
      end
    end
  end
end
