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
      new_res = Reservation.new(start_date, end_date, room) #is nil needed?
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

    def available_rooms(range) #putting in dates gives you all available rooms
  
      start_date = range.start_date
      end_date = range.end_date

      range_length = (end_date - start_date) - 1  #minus 1 so the end date is not counted

      not_available = []   #collects

      range_length.to_i.times do |i|
        res_by_date_array = reservations(start_date + i)  #a loop that goes over every day in the range and pulls in reservations 

        res_by_date_array.each do |res|
          not_available << res.room      #takes just the room of the reservations for a date and puts them in an array
        end
      end

      rooms_available_for_range = []

      20.times do |i|
        if not_available.include?(i+1)   #take the array made above and looks for each room number 1-20
          nil
        else
          rooms_available_for_range << (i + 1)  # if the room number is not in the not_available array the room number gets added to the rooms_available array.
        end
      end

      if rooms_available_for_range.length > 0
       return rooms_available_for_range
      else 
      raise ArgumentError, "There are no room available for that date range :("
      end
    end

    def res_with_valid_dates(range)
      room = available_rooms(range)[0]
      
      reserve_room(range.start_date, range.end_date, room)
    end

    def block_available(date_range, collection_of_rooms)
      available_rooms_array = available_rooms(date_range)
      collection_of_rooms.each do |room|
        if available_rooms_array.include?(room)
          nil
        else
          raise ArgumentError, "Room #{room} is not available for that date range :("
        end
      end
      nil
    end
  end
end
