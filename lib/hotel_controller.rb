module Hotel
  class HotelController
    attr_reader :rooms
    attr_accessor :reservations
    def initialize
      @rooms = Array.new(20){|i| Hotel::Room.new(i+1)}
      @reservations = []
    end
  
    # Wave 1
    # def rooms
    #     @hotel_controller = Hotel::HotelController.new
    #     room_list = @hotel_controller.rooms 
    #   return room_list
    # end

    # def reserve_room(start_date, end_date)
    #   # start_date and end_date should be instances of class Date
    #   return Reservation.new(start_date, end_date, nil)
    # end

    def reservations_list(date)
      reservation_list = reservations.select do |res|
        res.date_range.include?(date)
        end 
        return reservation_list
    end

    # Wave 2
    def available_rooms(start_date, end_date)
      # start_date and end_date should be instances of class Date
      return []
    end
  end
end
