require_relative "room"
require_relative "date_range"

module Hotel 
  class Reservation 

    attr_accessor :id, :room_num, :start_date, :end_date, :range

    def initialize(id:, room_num:, start_date:, end_date:, range: DateRange.new(start_date: start_date, end_date: end_date))
      @id = id
      @room_num = room_num
      @start_date = start_date
      @end_date = end_date 
      @range = range 
    end 

    def total_cost
      num_nights = @range.nights 
      room = Room.new(number: @room_num)
      room_cost = room.cost 
      return num_nights*room_cost 
    end 
    
  end
end  