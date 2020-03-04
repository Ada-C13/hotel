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
      @all_rooms = Room.create_rooms(20)
      return @all_rooms
    end
    
    
  end
end



STEPHANIE = 1