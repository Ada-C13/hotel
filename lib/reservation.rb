require 'date'

module Hotel
  class Reservation
    attr_reader :res_id, :start_date, :end_date, :room

    def initialize(
      # these are mandatory parameters for Reservation.new
      res_id:, 
      start_date:, 
      end_date:,
      room:
      
    )
      # these are instance variables
      @res_id = res_id
      @room = room
      # @res_duration
      @total_cost



      if start_date.is_a?(String)
        start_date = Date.parse(start_date)
      end
      @start_date = start_date
    
      if end_date.is_a?(String)
        end_date = Date.parse(end_date)
      end
      @end_date = end_date

    end #initialize end

    
    
    def res_duration
      @res_duration = @end_date - @start_date
      return @res_duration  
    end

    # def find_total_cost
    #    @total_cost = @res_duration * @room.cost
    #    return @total_cost




  #  def is_room_available
   # end

  end #class Reservation end
  
end #HotelController end






# make method to calculate total cost of reservation. cost * nights

# i need total num of nights. so subtract start date from end date  and (subtract one) for the checkout day. 

# create loop to 
