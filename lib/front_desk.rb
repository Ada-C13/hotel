require "date"
require_relative "date_range"
require_relative "reservation"

module Hotel
  class FrontDesk
    attr_reader :rooms, :reservations
    
    def initialize
      @rooms = (1..20).map {|num| num}
      @reservations = []
    end

    def reserve_room(start_date, end_date)  
      # generate all the dates that are in the time frame of start_date and end_date
      id = 1
      date_range = Hotel::DateRange.new(start_date, end_date)
      room_num = 1
      reservation = Hotel::Reservation.new(
        id = id, 
        date_range = date_range, 
        room_num = room_num
      )
      id += 1
      room_num += 1
      add_reservation(reservation)
      return reservation
      # TODO: loop through the list of reservations and check if there are still avaiable rooms in these dates
    end

    def add_reservation(reservation) # instance of Reservation class
      @reservations << reservation
    end


    # check the reservation of a specific date
    def check_reservations(date) #(string)
      check_date = Date.parse(date)
      return @reservations.select {|reservation| reservation.date_range.all_dates.include? check_date}
    end
  end
end

