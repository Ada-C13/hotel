require 'time'
require 'date'
require_relative 'manager'
require_relative 'reservation'

module Hotel
  class Room
    attr_reader :rm_num
    attr_writer
    attr_accessor 

    def initialize(rm_num:)
      @rm_num = rm_num
     

      if rm_num.nil? || rm_num <= 0 
        raise ArgumentError, 'Room number cannot be blank or less than one.'
      end

      # if cost <= 0 
      #   raise ArgumentError, 'Room number cannot be blank or less than one.'
      # end
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
  
    

  end
end
