module Hotel
  class Reservation
    attr_reader :id, :start_date, :end_date, :room, :cost

    def initialize(
      # these are mandatory parameters for Reservation.new
      id:, 
      start_date:, 
      end_date:, 
      room:
    )
      # these are instance variables and differ from each instance
      @id = id
      @start_date = start_date
      @end_date = end_date
      @room = room
      @cost = 200


    end #initialize end

  end #class Reservation end
  
end #HotelController end