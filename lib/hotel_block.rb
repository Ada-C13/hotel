module Hotel
  class HotelBlock 
    attr_reader :date_range , :rooms , :discounted_rate
    def initialize(date_range, rooms, discounted_rate)
      @date_range = date_range
      @rooms = []
      @discounted_rate = discounted_rate
    end
  end
end

# to create a hotel block
  # 1- check to see if the the room is available or not with the given date range
      #- check that within the reservations list 
      # if the room is overap with the given date range
          # the room cannot be added to the hotel block
      # else add the room to the hotel block with the given date range

  # 2

