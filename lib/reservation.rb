require 'date'

require_relative 'date_range.rb'
require_relative 'room.rb'

module Hotel
  class Reservation
    attr_reader :start_date, :end_date, :room, :date_range
    
    def initialize(start_date, end_date, room)
      # raise ArgumentError.new("room must be an instance of room") if room.class != Hotel::Room
      @start_date = start_date
      @end_date = end_date
      @room = room # instance of room class
      @date_range = Hotel::DateRange.new(start_date, end_date)
    end

    def cost
      return Hotel::DateRange.new(@start_date, @end_date).nights * @room.cost
    end

    # def date_range_for_reservation
    #   return Hotel::DateRange.new(@start_date,@end_date)
    # end

  end
end