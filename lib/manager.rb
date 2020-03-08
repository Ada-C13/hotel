require 'time'
require 'date'
require_relative 'room'
require_relative 'reservation'


module Hotel
  class Manager
    attr_reader :num #:rm_reservations
    attr_writer
    attr_accessor  

    def initialize(num: 20)
      all_rooms = Manager.create_rooms
      return all_rooms
    end

    def self.create_rooms(num: 20)
      all_rooms = []
      i = 1
      num.times do 
        all_rooms << Room.new(rm_num: i)
        i + 1
      end
      return all_rooms
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
            room.book_room(start_date, end_date)
            return
          end 
        end
          raise ArgumentError "No rooms available"
    end

    def res_by_room(rm_num, start_date, end_date)
    # all res for a specific room, on a certain date range 
    # make empty temporary array
    # access the room
    # loop through all reservations 
    # if date matches
    # push res object into new array 
    # return new array
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

    def total_cost(recloc)
    # gives the total cost of a given reservation 
    # accesses reservation 
    # returns total cost 
    end


  end
end


