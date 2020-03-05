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
      @rm_reservations = []
     
      if rm_num.nil? || rm_num <= 0 
        raise ArgumentError, 'Room number cannot be blank or less than one.'
      end
    end

     
    ## in order to check availablity, will call each room 
      #do they have reservations? no - book, yes, loop through resses
      #loop through each res to check for date conflict 

    def is_available(date) ## nn to ask when calling is_available for date range but also call by each date?
      if @rm_reservations == nil #if no res then room is avail 
        return true
      else
        @rm_reservations.each { |res| 
          if date < res.end_date && date > res.start_date
            return true
          else
            return false
          end
        }
      end
        #checking availablity by date 
        # make both res and new res ranges and see if any matches?

        #loop through itselfs reservations for conflicts 
        #return true false
    end
    
    def book_room(start_date, end_date)
      Reservation.new(start_date: start_date, end_date: end_date, rm_num: @rm_num)
      @rm_reservations << @reservation
      
    end
    #     HFHTJY.conflict(3/14/2020)
    

  end 
end