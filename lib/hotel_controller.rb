require 'date'

require_relative 'reservation'
require_relative 'date_range'

module Hotel
  class HotelController
    attr_reader  :reservation_list,  :room_list, :specific_date_reservation
    # Wave 1
    def initialize
    @reservation_list = Hash.new
    @room_list = [ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]
    end
     
    def reserve_room(start_date, end_date, room_num)
      # start_date and end_date should be instances of class Date   
      raise ArgumentError.new("They are not the valid Date class for start_date and end_date") if (start_date.class != Date || end_date.class != Date)
      resevation_duration = DateRange.new(start_date, end_date)
      new_reservation = Reservation.new(resevation_duration,room_num)
      reservation_list[reservation_list.length + 1] = new_reservation
    end
  
    def reservations(date) 
      #@reservation_list.each_value do |reservation|
      #if date.between?(reservation.date_range.start_date, reservation.date_range.end_date)
      #  @specific_date_reservation << reservation
      #end
      #end
    return @specific_date_reservation
    end

    # Wave 2
    def available_rooms(start_date, end_date)
      # start_date and end_date should be instances of class Date
      return []
    end
  end
end