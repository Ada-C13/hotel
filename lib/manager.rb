require 'time'
require 'date'
require_relative 'room'
require_relative 'reservation'


module Hotel
  class Manager
    attr_reader :num, :all_rooms, :rm_reservations, :recloc
    attr_writer
    attr_accessor  

    def initialize(num: 20)
      if num == nil || num == 20 
        @all_rooms = Manager.create_rooms
      else
        @all_rooms = Manager.create_rooms(num: num)
      end
    end

    def self.create_rooms(num: 20)
      @all_rooms = []
      i = 1
      num.times do 
        @all_rooms << Room.new(rm_num: i)
        i += 1
      end
      return @all_rooms
    end
  
    def show_all_rooms  
      list_rooms = []
      @all_rooms.each do |room|
        list_rooms << room.rm_num
      end 
      return list_rooms
    end 

    def book_res(start_date, end_date)
        @all_rooms.each do |room|
          if room.is_available_range(start_date, end_date) == true 
            return room.book_room(start_date, end_date)
          end 
        end
        raise ArgumentError.new("No rooms available")
    end

    def res_by_room(rm_num, start_date, end_date)
    # all res for a specific room, on a certain date range 
      res_array = []
      @found_room = @all_rooms.find {|room| room.rm_num}
      (start_date..end_date).each do |date|
        res = @found_room.has_res_by_date(date)
          if res != false && res_array.include?(res) == false
            res_array << res
          end
      end
      return res_array
    end 

    def res_by_date(date) 
    # gives all reservations for a specific date 
    # make empty temporary array
    # loop through all rooms 
    # each room loop through reservation 
    # if date contains reservation 
    # push reservation into new array 
    # return new array 
    end 

    def rooms_available_by_date(start_date, end_date)
    # I can view a list of rooms that are not reserved for a given date range, 
    # so that I can see all available rooms for that day
    # make empty temporary array 
    # loop through all rooms 
    # call room's is_available method 
    # if == true 
    # push rm_num into temporary array 
    # return new array 
    end

    def find_total_cost(rec_loc)
    # gives the total cost of a given reservation 
      @all_rooms.each do |room|
        res = @rm_reservations.select {|reservation| @reservation.recloc == rec_loc}.first
        return res.recloc
      end
    end

  end
end


