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
      # room.date_range(start_date, end_date)


      all_available = []
      (start_date..end_date).each do |date| ## nn to parse 
        @rooms.rm_reservations.each do |date| ## nn to change to each instance of room 
          if @room.is_available(date) == true #if room is availble call book method ## for every day thoooo
            all_available << true
          else 
            all_available << false # move onto the next room?
          end 
        end

        if all_available.include? false
          #reset all_available  
        else 
          @room.book_room(start_date, end_date)
          #return
        end 
        
      end
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


