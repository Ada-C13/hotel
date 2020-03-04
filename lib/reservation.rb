require_relative "date_range"
module Hotel
  class Reservation
   
    # Feel free to change this method signature as needed. Make sure to update the tests!
    attr_reader :id, :date_range, :room
    def initialize(id, start_date, end_date, room)
      @id = id
      @date_range = Hotel::DateRange.new(start_date, end_date)
      @room = room
    end
    
    def ==(other)
      id == other.id 
    end


    # def cost
    #   total = date_range.calculate_nights * 200.00
    #   return total
    # end
    
    #cost DateRange.calculate_nights * 200
  end
end