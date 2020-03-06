require 'date'

require_relative 'reservation'
require_relative 'date_range'

module Hotel
  class HotelController
    attr_reader :reservation_list
    attr_accessor :room_list, :specific_date_reservation

    # Wave 1
    def initialize(number_of_room)
    @reservation_list = Hash.new
    @room_list = Array.new
  
    n = 1
    number_of_room.times do
      @room_list << "Room #{n}"
      n += 1
    end

    end
     
    def get_room_list 
      return @room_list
    end

    def reserve_room(start_date, end_date, customer_name)
      # start_date and end_date should be instances of class Date   
      # new data range and reservation created 
      # first available room assigned to the new reservation 
      raise ArgumentError.new("They are not the valid Date class for start_date and end_date") if (start_date.class != Date || end_date.class != Date)
      resevation_duration = DateRange.new(start_date, end_date)
      new_reservation = Reservation.new(resevation_duration, customer_name)
      new_reservation.cost
      reservation_id = @reservation_list.length + 1
      new_reservation.room_num = self.available_rooms(start_date, end_date)[0]
      @reservation_list[reservation_id] = new_reservation
    end
  
    def reservations(date) 
      specific_date_reservation = Array.new
      @reservation_list.each_value do |reservation|
        if reservation.date_range.include?(date)
          specific_date_reservation << reservation
        end
      end
      if specific_date_reservation.empty?
        return "There is no reservation for today!"
      else
        return specific_date_reservation
      end  
    end


    def get_list_of_reservations(specific_room, start_date, end_date)
      date_range_reservation_list = Array.new
      check_date_range = Hotel::DateRange.new(start_date, end_date)
      @reservation_list.each_value do |reservation|
        if (reservation.date_range.overlap?(check_date_range) )&& (reservation.room_num == specific_room)
          date_range_reservation_list << reservation
        end
      end
      return date_range_reservation_list 
    end



    def get_reservation_cost(reservation_id)
      return self.reservation_list[reservation_id].cost
    end

    # Wave 2
    def available_rooms(start_date, end_date)
      # start_date and end_date should be instances of class Date
      available_rooms_list = Array.new
      occupied_rooms_list = Array.new
      perferred_date_range = Hotel::DateRange.new(start_date, end_date)
      @reservation_list.each_value do |reservation|
        if reservation.date_range.overlap?(perferred_date_range)
          occupied_rooms_list << reservation.room_num
        end
      end
      if occupied_rooms_list.empty?
        return @room_list
      else
        return @room_list - occupied_rooms_list
      end
    end
  end
end