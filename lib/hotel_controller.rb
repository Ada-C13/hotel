require 'Date'
module Hotel
  class HotelController
    attr_accessor :reservation_array

    def initialize
      @reservation_array = []
    end

    # Wave 1
    def rooms 
      rooms = [1..20]
      return rooms    # You might want to replace this method with an attr_reader
    end

    def reserve_room(start_date, end_date, room, block_id = nil, blocks_room_status = nil)
      new_res = Reservation.new(start_date, end_date, room, block_id ) #is nil needed?
      @reservation_array << new_res
      return new_res
    end


    def reservations(date)
      if date.class == String
        date = Date.parse(date)
      end

      res_by_date = []

      @reservation_array.each do |res| 
        if date.between?(res.start_date,(res.end_date)-1)  # note to me! added the minus one here!!!!
          res_by_date << res
        end 
      end

      return res_by_date
    end

    
    def reservation_by_date_room(date,room_num) # may need to add block room here?
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

    def block_available(date_range, collection_of_rooms)  #tested in block test because i wrote this for initialization
      if collection_of_rooms.length < 2 || collection_of_rooms.length > 5
        raise ArgumentError, "a block needs to have 2 to 5 rooms"
      end

      available_rooms_array = available_rooms(date_range)
      collection_of_rooms.each do |room|
        if available_rooms_array.include?(room)  #checking to make sure each room is available
          nil
        else
          raise ArgumentError, "Room #{room} is not available for that date range :("
        end
      end
      true  #returning true is all the blocks rooms are available.
    end

    def set_aside_block (date_range, collection_of_rooms, block_id) 
      unless block_available(date_range, collection_of_rooms)  #if the block_available function returned true do nothing
        raise ArgumentError, "One or more of your rooms are not available"  # not needed the exceptions is raised in block available
      end

      collection_of_rooms.each do |room|
        reserve_room(date_range.start_date, date_range.end_date, room, block_id)
      end
    end

    def block_status_by_id(block_id)  #I can check whether a given block has any rooms available
      @reservation_array.each do |res|
        if (res.block_id == block_id) && (res.blocks_room_status == nil)
          return true  #check this if block because it is returing a vlaue so only go throug it once
        else
           nil
        end  
      end
      return false

    end

    def reserve_block_room(block_id, room)
      reservation_array.each do |res|
        if (res.block_id == block_id) && (res.room == room) && (res.blocks_room_status == nil)
          res.blocks_room_status = "unavilable"
          return
        end
      end
      raise ArgumentError, "No rooms in the block are available"
    end

  end
end
