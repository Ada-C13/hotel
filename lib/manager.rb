require 'time'
require 'date'
require_relative 'room'
require_relative 'reservation'


module Hotel
  class Manager
    attr_reader :num
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

    def book_res(start_date, end_date)
      all_available = []
      (start_date..end_date).each do |date| ## nn to parse 
        room.rm_reservations.each { |date|
          if room.is_available(date) == true #if room is availble call book method ## for every day thoooo
            all_available << true
          else 
            all_available << false
          end 
        }
      end
      if all_available.include? false
        # loop through next room 
      else 
        room.book_room(start_date, end_date)
    end

  end
end


