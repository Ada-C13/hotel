require 'Date'
module Hotel
  class HotelController

    def initialize
      @reservation_array = []
    end

    # Wave 1
    def rooms 
      rooms = [1..20]
      return rooms    # You might want to replace this method with an attr_reader
    end

    def reserve_room(start_date, end_date)
      new_res = Reservation.new(start_date, end_date, nil) #is nil needed?
      @reservation_array << new_res
      return new_res
    end


    def reservations(date)
      if date.class == String
        date = Date.parse(date)
      end

      res_by_date = []

      @reservation_array.each do |res| 
        if date.between?(res.start_date,res.end_date)
          res_by_date << res
        end 
      end

      return res_by_date
    end

    # Wave 2
    def available_rooms(start_date, end_date)  
      # start_date and end_date should be instances of class Date
      return []
    end
  end
end
