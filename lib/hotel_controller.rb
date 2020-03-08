require 'date'

require_relative 'reservation'
require_relative 'date_range'
require_relative 'hotel_block'

module Hotel
  class HotelController
    attr_reader :reservation_list
    attr_accessor :room_list, :specific_date_reservation, :hotel_block_list

    # Wave 1
    # default number of room in the hotel is 20 
    def initialize(number_of_room = 20)
    @reservation_list = Hash.new
    @room_list = Array.new
    @hotel_block_list = Hash.new
    
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
      if self.available_rooms(start_date, end_date)[0] == nil
        raise ArgumentError.new("Opps! There is no room availiable for this date range!")
      else 
        new_reservation.room_num = self.available_rooms(start_date, end_date)[0]
      end
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
        raise ArgumentError.new("There is no reservation on this day!")
      else
        return specific_date_reservation
      end  
    end


    def get_list_of_reservations(specific_room, start_date, end_date)
      date_range_reservation_list = Array.new
      check_date_range = Hotel::DateRange.new(start_date, end_date)
      @reservation_list.each_value do |reservation|
        if (reservation.date_range.overlap?(check_date_range) ) && (reservation.room_num == specific_room)
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
        available_rooms_list = @room_list - occupied_rooms_list
        if available_rooms_list.empty? 
          raise ArgumentError.new("There is no more room for you!")
        else
          return available_rooms_list
        end
      end
    end

   #Wave 3 Hotel Block
    def create_hotel_block(start_date, end_date, number_of_rooms)
      raise ArgumentError.new("They are not the valid Date class for start_date and end_date") if (start_date.class != Date || end_date.class != Date)
      raise ArgumentError.new("There is not enough room!") if number_of_rooms > 5 || number_of_rooms > self.available_rooms(start_date, end_date).length
      block_duration = DateRange.new(start_date, end_date)
      new_hotel_block = BlockReservation.new(block_duration, number_of_rooms)
      number_of_rooms.times do 
        block_room = self.reserve_room(block_duration.start_date, block_duration.end_date, "Hotel Block Reserve")
        block_room.status = :open_hotel_block
        new_hotel_block.block_reservations << block_room
      end
      hotel_block_id = hotel_block_list.length + 1
      hotel_block_list[hotel_block_id] = new_hotel_block
      return new_hotel_block
    end

    # check if a given block has any rooms available
    # if there is available room - will return the rooms that are open
    # else will raise argument
    
    def check_hotel_block_list_availability(hotel_block_id)
      raise ArgumentError.new("Not a valid Hotel Block ID!") if !(hotel_block_list.keys.include? hotel_block_id)
      available_rooms_in_block = Array.new
      hotel_block_list[hotel_block_id].block_reservations.each do |reservation|
        if reservation.check_status
          available_rooms_in_block << reservation.room_num
        end
      end

      if available_rooms_in_block == []
        raise ArgumentError.new("No room available in this hotel block anymore!")
      else 
        return available_rooms_in_block
      end
    end

    def reserve_room_hotel_block(hotel_block_id, customer_name, specific_room) 
      raise ArgumentError.new("Not a valid Hotel Block ID!") if !(hotel_block_list.keys.include? hotel_block_id)
      hotel_block_list[hotel_block_id].block_reservations.each do |reservation|
        # check if the specific room requested in within the hotel block and not booked by another guests
        if hotel_block_list[hotel_block_id].check_valid_room(specific_room) && reservation.check_status  
        #if (reservation.room_num == specific_room) && (reservation.status != :reserved_hotel_block)
          booking_room = reservation
          booking_room.customer_name = customer_name
          booking_room.status = :reserved_hotel_block
        end  
      end
    # raise ArgumentError.new("This is not a reserved room for the hotel block guest!")
    end
  end
end