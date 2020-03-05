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

      # if rm_num has a value 
      if @rm_num != nil
        #check that room for availablity 
        @room.rm_num.
        #if rm_reservations == empty
          #book room
        #else loop through instances of res for date
          # if date == no conflict 
          #   book room 
          # if date has conflict
            #return error


      # if rm_num == nil 
        # then cycle through rm numbers to find availablity 

      
      # (@rm_reservations = array of res instances)

      # if conflict == true
      #   raise ArgurmentError
      # end
    end

    def conflict(start_date, end_date)
      reservation_dates = (start_date..end_date).each {|date| 
        if date < end_date and date > start_date
          return true
        else
          return false
        end}
    end

    
  


  end
end

