require_relative "date_range"
module Hotel
  class Reservation
   
    # Feel free to change this method signature as needed. Make sure to update the tests!
    def initialize(id, date, room_nr)
      @id = id
      @date = Hotel::DateRange.new(start_date, end_date)
      @room_nr = Hotel::DateRange.room_nr
      # initialize(id, date, room, )
      # @start_date = start_date
      # @end_date = end_date
      # @room = room
      # @status = status
      # @date = Hotel::DateRange.new(start_date, end_date)
      # room = Hotel::Room.new(room_nr, cost)


    end

    def cost
      return 200
    end
    
    #cost DateRange.calculate_nights * 200
  end
end