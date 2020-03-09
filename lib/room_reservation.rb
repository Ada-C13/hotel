require 'date'

require_relative 'date_range.rb'
require_relative 'room.rb'

module Hotel
  class RoomReservation < Reservation
    attr_reader :start_date, :end_date, :room, :date_range
    
    def initialize(start_date, end_date, room)
      super(start_date,end_date)
      raise ArgumentError.new("room must be an instance of room") if room.class != Hotel::Room

      @room = room # instance of room class
      @date_range = get_date_range(start_date, end_date)
    end

    def cost
      return Hotel::DateRange.new(@start_date, @end_date).nights * @room.cost
    end

  end
end