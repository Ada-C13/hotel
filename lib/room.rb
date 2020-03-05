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

    # def is available 
        #loop through itselfs reservations for conflicts 
        #return true false
    
    # def book_room 
      #makes new Reservation 
      # Reservation.new(start_date: start_date, end_date: end_date, rm_num: @rm_num)
      #adds to itself's  reservations 

    # room1 = [res_obj1, res_obj2]

  

    #     HFHTJY.conflict(3/14/2020)
    

  end 
end