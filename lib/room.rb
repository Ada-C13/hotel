require 'time'
require 'date'
require_relative 'manager'
require_relative 'reservation'

module Hotel
  class Room
    attr_reader :rm_num, :cost
    attr_writer
    attr_accessor 

    def initialize(rm_num:, cost: 200)
      @rm_num = rm_num
      @cost = cost

      if rm_num.nil? || rm_num <= 0 
        raise ArgumentError, 'Room number cannot be blank or less than one.'
      end

      if cost <= 0 
        raise ArgumentError, 'Room number cannot be blank or less than one.'
      end
    end



  end
end

YAYME = 1

