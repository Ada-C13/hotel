require 'date'

module Hotel
  class Reservation
    attr_reader :start_date, :end_date, :room

    def initialize(
      start_date:, 
      end_date:,
      room:
      
    )
      @room = room
      @start_date = start_date
      @end_date = end_date
      @total_cost = find_total_cost


    end 
    
    def res_duration
      res_duration = @end_date - @start_date
      return res_duration - 1  # (-1) accounts for the checkout day - no charge
    end

    def find_total_cost
       @total_cost = res_duration * @room.cost
       return @total_cost
    end

  end 
  
end 
