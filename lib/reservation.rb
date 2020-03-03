module Hotel
  class Reservation
    attr_reader :check_in_time, :check_out_time, :room, :date_range
    def initialize(check_in_time, check_out_time, room: 1)
      @id = 
      @date_range = Hotel::DateRange.new(check_in_time, check_out_time)
      @room
      @cost = @date_range.
      #logic to find room
    end



  end
end