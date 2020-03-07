require 'date'

module Hotel
  class Reservation
    attr_reader :start_date, :end_date, :room

    def initialize(
      # these are mandatory parameters - keyword arguments - for Reservation.new 
      start_date:, 
      end_date:,
      room:
      
    )
      # these are instance variables
      @room = room
      @start_date = start_date
      @end_date = end_date
      @total_cost = find_total_cost


    end #initialize end

    
    
    def res_duration
      res_duration = @end_date - @start_date
      return res_duration -1  # (-1) accounts for the checkout day - no charge
    end

    def find_total_cost
       @total_cost = res_duration * @room.cost
       return @total_cost
    end





  #  def is_room_available
   # end

  end #class Reservation end
  
end #Hotel end








# create loop to 
