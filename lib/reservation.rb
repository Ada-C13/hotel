require 'time'
require 'date'
require 'securerandom'
require_relative 'manager'
require_relative 'room'

module Hotel
  class Reservation
    attr_reader :start_date, :end_date, :rm_num, :cost_per_day, :total_cost, :recloc
    attr_writer
    attr_accessor

    
    def initialize(start_date:, 
      end_date:, 
      rm_num: nil, 
      cost_per_day: 200, 
      total_cost: nil, 
      recloc: nil)
     
      @start_date = Date.parse "#{start_date}"
      @end_date = Date.parse "#{end_date}"
      @cost_per_day = cost_per_day
      @rm_num = rm_num
      res_length = (Date.parse("#{end_date}") - Date.parse("#{start_date}")).to_i
      @total_cost = cost_per_day * res_length
      @recloc = SecureRandom.alphanumeric(6)
      
      ## make date class?
      ## make date methods w/in res?
    end

 

    def conflict(start_date, end_date)
      #turn into range
      #loop through every date in the range:
        # if date < end_date and date > start_date
        #   return true
        # else
        #   return false
      # 
    end

  
    
    ## nn to build method to check if inputed rm num is avail
      ## if the inputed room is unavailable - suggest different room or error?
    ## nn to build method, if rm_num is nill, then to search rooms for availablity then assign 
    ## nn add in initalize to make array of booked dates to go back to room?


  end
end

