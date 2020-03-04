require 'time'
require 'date'
require_relative 'manager'
require_relative 'room'

module Hotel
  class Reservation
    attr_reader :start_date, :end_date, :rm_num, :cost_per_day
    attr_writer
    attr_accessor

    
    def initialize(start_date:, end_date:, rm_num: nil, cost_per_day: 200)
     
      # start_date = start_date.to_s 
      # end_date = end_date.to_s
      @start_date = Date.parse"#{start_date}"
      @end_date = Date.parse"#{end_date}"
      @rm_num = rm_num
      res_length = (@end_date - @start_date).to_i
      @total_cost = cost_per_day * res_length
      
      # nn to make recloc # and store trip in manager 
      ## make date class?
      ## make date methods w/in res?
    end

    
    ## nn to build method to check if inputed rm num is avail
      ## if the inputed room is unavailable - suggest different room or error?
    ## nn to build method, if rm_num is nill, then to search rooms for availablity then assign 
    ## nn add in initalize to make array of booked dates to go back to room?


  end
end

TIFFANY = 1