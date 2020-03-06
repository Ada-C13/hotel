require "date"
require_relative "date_range"
require_relative "reservation"

module Hotel
  class FrontDesk
    attr_reader :rooms, :reservations
    
    def initialize
      @rooms = (1..20).map {|num| num}
      @reservations = {}
    end

    def reserve_room(start_date, end_date)  
      date_range = Hotel::DateRange.new(start_date, end_date)
      id = 1
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
      if !(@reservations.key?(reservation.room_num))
        @reservations[reservation.room_num] = [reservation]
      else
        @reservations[reservation.room_num] << [reservation]
      end
      return @reservations[reservation.room_num] # return a list of reservations of that specific room number
    end

    # check the reservation of a specific date
    def check_reservations_on_date(date) #(string)
      check_date = Date.parse(date)
      lists = []
      @reservations.each_value do |reservations_of_each_room| 
        reservations_of_each_room.each do |reservation|
          if reservation.date_range.dates_exclude_last.include? check_date
            lists << reservation
          end
        end
      end
      return lists
    end

    # check the reservation in a date range
    def check_reservations_in_date_range(start_date, end_date)  
      date_range = Hotel::DateRange.new(start_date, end_date)
      lists = []
      @reservations.each_value do |reservations_of_each_room| 
        reservations_of_each_room.each do |reservation|
          # if reservation.date_range.all_dates.include? date_range.all_dates
          if reservation.date_range.overlap_include_last? date_range
            lists << reservation
          end
        end
      end
      return lists
    end
  end
end
