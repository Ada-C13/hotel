require 'date_range'
require 'reservation'

module Hotel
  class FrontDesk
    attr_accessor :reservations
    
    def initialize(reservations:nil )
      @reservations = reservations || []
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
      times_overlap = @reservations.count{|bookings|bookings.date_range.overlap(date_range)}

      available_rooms = self.room_available(date_range)
      unless times_overlap < 20
        raise ArgumentError, "cannot reserve room since all rooms are booked"
      end 
      
      assign_room = available_rooms[0]
      new_reservation = Hotel::Reservation.new(date_range:date_range,room_num:assign_room)
      @reservations << new_reservation
      return new_reservation 
    end 

    #room_available method - list rooms that are available for a given date range
    def room_available(date_range)
      rooms_not_available_res = @reservations.select{|bookings|bookings.date_range.overlap(date_range)}
      rooms_num_not_available = rooms_not_available_res.map{|bookings|bookings.room_num}
      available_rooms = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20] - rooms_num_not_available
      return available_rooms.sort!
    end 

    #reservation_cost method 
    def reservation_cost(reservation)
      looked_up_reservation = @reservations.select {|bookings| reservation==bookings}
      cost = looked_up_reservation[0].date_range.duration
      return cost* (looked_up_reservation[0].room_rate)
    end 

    #create_block method 
    def create_block(start_date,end_date,num_of_rooms,room_rate)
      date_range = Hotel::DateRange.new(start_date:start_date,end_date:end_date)
      rooms_available = self.room_available(date_range)

      if num_of_rooms > 5 
        raise ArgumentError, "max is 5 for Number of Rooms"
      end 

      unless rooms_available.length >= num_of_rooms
        raise ArgumentError, "Not Enough Rooms"
      end 

      block_array = []
      random_block_id = rand(1000..9999)

      num_of_rooms.times do 
        new_block = self.request_reservation(start_date,end_date)
        new_block.room_rate = room_rate
        new_block.block_tag = "block-available"
        new_block.reservation_id = "B" + random_block_id.to_s + "-" + new_block.reservation_id.to_s
        self.reservations << new_block
        block_array << new_block
      end 
      puts block_array[0].reservation_id.to_s[0..4]
      return block_array
    end 

    #book_room_of_block (assume manager know unique block_id BXXXX)
    def book_room_of_block(block_id)
      look_up_block = @reservations.select{|booking|booking.reservation_id.to_s[0..4] == block_id }
      rooms_available = look_up_block.count{|room|room.block_tag == "block-available"}

      unless rooms_available > 0
        raise ArgumentError, "All rooms in this block are booked!"
      end 

      reservation_id_to_change = look_up_block[0].reservation_id

      @reservations.each do |booking|
        if booking.reservation_id.to_s == reservation_id_to_change.to_s
          booking.block_tag = "block-booked"
        end 
      end 
      

    end 


    #hotel block pseudocode
    #ability to create hotel block, this will mark as normal reservation 
        #but tag with block-available and assign reservation id with B0 to B9
    #make reservation within block method change tag to block-booked

    
  end 
end