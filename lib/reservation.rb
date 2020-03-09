require 'time'
require 'date'
require 'securerandom'
require_relative 'manager'
require_relative 'room'

module Hotel
  class Reservation
    attr_reader :start_date, :end_date, :rm_num, :cost_per_day, :total_cost, :recloc

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
      if recloc == nil
        @recloc = SecureRandom.alphanumeric(6)
      else 
        @recloc = recloc
      end
    end
  end
end

