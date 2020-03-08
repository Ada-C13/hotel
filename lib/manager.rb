require 'time'
require 'date'
require_relative 'room'
require_relative 'reservation'


module Hotel
  class Manager
    attr_reader :num, :all_rooms, :rm_reservations
    attr_writer
    attr_accessor  

    def initialize(num: 20)
      Manager.create_rooms
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
      all_rooms.each do |room|
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

    def find_total_cost(recloc)
    # gives the total cost of a given reservation 
    # loop through all rooms reservations to look for recloc? 
    # accesses reservation 
    # # 
    # @all_rooms.select do |room|

    #   # driver = @drivers.select {|driver| driver.status == :AVAILABLE}.first

    # end
    #   @reservation = Hotel::Reservation(recloc: recloc)
    #   total_cost = @reservation.total_cost
    # # returns total cost 
    #   return total_cost
    end

  end
end


