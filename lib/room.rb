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
    end

    


    # nn to make all_rooms array that contains hashes with date: recloc
    # {date: date, reservation: res #} -or-
    # {date: reservation #}
    # room1 = [{3/14/2020: HFHTJY}, {3/15/2020: HFHTJY}, {3/16/2020: HFHTJY} {3/17/2020: HFSDDY}]
    # room1 = [res_obj1, res_obj2]

    #   def book(startdate, end)
    #       newRes = new res(start, end)
    #       @resses.push(newRes)


    #     HFHTJY.conflict(3/14/2020)

  end 
end