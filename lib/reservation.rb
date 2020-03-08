require 'date'


require_relative 'frontdesk.rb'
require_relative 'date.rb'

module Hotel
  class Reservation < DateRange
    attr_accessor :start_date, :end_date, :num_rooms, :assigned_room, :discount, :block, :block_key
    
    COST = 200.00

    def initialize(start_date:, end_date:, num_rooms:, discount: nil, block: :SINGLE, block_key: nil)
      @start_date = start_date 
      @end_date = end_date 
      @num_rooms = num_rooms
      @assigned_room = []
      @discount = discount
      @block = block
      @block_key = block_key

      raise ArgumentError.new("Invalid times: #{@start_date} comes after #{@end_date}") if (@start_date > @end_date || @start_date == @end_date)

      raise ArgumentError.new("Invalid room request: provided #{@num_rooms} instead of an Integer") if @num_rooms.class != Integer

      raise ArgumentError.new("Invalid room request: requested #{@num_rooms} rooms, #{@num_rooms-5} too many.") if @num_rooms > 5

      raise ArgumentError.new("Invalid block key. Not valid for single room reservations") if @num_rooms == 1 && block_key != nil
      
      raise ArgumentError.new("Status and room argument: #{@num_rooms} room, should not be noted as a block") if (@num_rooms == 1 && @block == :BLOCK)

      raise ArgumentError.new("Invalid status. Please choose: single or block.") unless [:SINGLE, :BLOCK].include? block
    end

    def total_cost
      @num_rooms == 1 ? final_bill = (@end_date - @start_date)*@num_rooms*COST : final_bill = (@end_date - @start_date)*@num_rooms*COST*(1 - @discount)
      return final_bill
    end

    # def contains(date)
    #   (date >= @start_date && date < @end_date) ? true : false
    # end

    # def conflict?(new_start, new_end)
    #   if new_start >= @start_date && new_start < @end_date || new_end > @start_date
    #     return false
    #   elsif @end_date = new_start || new_start > @end_date || new_end < @start_date || new_end == @start_date
    #     return true
    #   end
    # end
  end
end