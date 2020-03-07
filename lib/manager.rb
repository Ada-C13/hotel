require 'time'
require 'date'
require_relative 'room'
require_relative 'reservation'


module Hotel
  class Manager
    attr_reader :num :rm_reservations
    attr_writer
    attr_accessor  

    def initialize
      @all_rooms = Manager.create_rooms(20)
      return @all_rooms
    end

    def self.create_rooms(num)
      all_rooms = []
      i = 1
      num.times do 
        all_rooms << Room.new(rm_num: i)
        i + 1
      end
      return all_rooms
    end
  
    def self.show_all_rooms
      # shows user list of all rooms in hotel
      # puts @all_rooms
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

    def res_by_date(date) 
      #gives all reservations for a specific date 
    end 

    def total_cost(recloc)
      #gives the total cost of a given reservation 
    end

    #must raise arugment error for invalid date 

  end
end


