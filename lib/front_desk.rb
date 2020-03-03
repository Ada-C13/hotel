require 'date_range'
require 'reservation'

module Hotel
  class FrontDesk
    attr_accessor :reservations, :rooms

    def initialize(reservations:nil ,rooms:nil)
      @reservations = reservations || []
      @rooms = {1 => [],2 =>[],3=>[]}
    end

    #access a list of all rooms in hotel
    def list_all
      display = ""
      @reservations.map do |bookings| 
        display += "Reservation_id = #{bookings.reservation_id} Start date = #{bookings.date_range.start_date} End_date =#{bookings.date_range.end_date} Room Number = #{bookings.room_num}\n"
      end 
      return display
    end 

    #access a list of reservations for a specific room number and date range
    def room_reservations_and_date(room_num,date)
      display = ""
      res_room_date_range = @reservations.select {|bookings| bookings.room_num == room_num && date.overlap(bookings.date_range)}
      res_room_date_range.map do |bookings|
        display += "Reservation_id = #{bookings.reservation_id} Start date = #{bookings.date_range.start_date} End_date =#{bookings.date_range.end_date} Room Number = #{bookings.room_num}\n"
      end 
      return display
    end 

    # check reservations of specific date
    def check_date_reservations(date)
      display = ""
      reservations_include_a_date = @reservations.select {|bookings| bookings.date_range.include_date(date)==true}
      reservations_include_a_date.map do |bookings|
        display += "Reservation_id = #{bookings.reservation_id} Start date = #{bookings.date_range.start_date} End_date =#{bookings.date_range.end_date} Room Number = #{bookings.room_num}\n"
      end 
      return display
    end 

    #request reservation 
    def request_reservation(start_date,end_date)
      date_range = Hotel::DateRange.new(start_date:start_date,end_date:end_date)
      # check if date_range overlap with other existing reservations
      times_overlap = @reservations.count{|bookings|bookings.date_range.overlap(date_range)}
      unless times_overlap < 20
        raise ArgumentError, "cannot reserve room since all rooms are booked"
      end 
      new_reservation = Hotel::Reservation.new(date_range:date_range)
      @reservations << new_reservation
      return new_reservation 
    end 


    

    #reservation_cost method 
    def reservation_cost(reservation)
      looked_up_reservation = @reservations.select {|bookings| reservation==bookings}
      cost = looked_up_reservation[0].date_range.duration
      return cost*200
    end 


    
  end 
end