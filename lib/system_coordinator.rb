require_relative 'room'
require_relative 'date_range'
require_relative 'reservation'
require_relative 'block'
require_relative 'no_availability_error'

module Hotel
  class SystemCoordinator    
    attr_reader :rooms

    @@next_block = 1

    def initialize(room_quantity = 20)
      @rooms = []   # Array.new(quantity){|i| Hotel::Room.new(i+1)}
      build_rooms(room_quantity)
    end

    def build_rooms(room_quantity)
      room_quantity.times do
        @rooms << Hotel::Room.new(@rooms.length + 1)
      end
    end

    def list_rooms
      return rooms
    end


    def find_reservations_by_date(date)
      reservations_by_date = []

      rooms.each do |room|
        room.bookings.each do |reservation|
          reservations_by_date << reservation if reservation.date_range.include_date(date)
        end
      end

      return reservations_by_date
    end


    def find_reservations_room_date(room_id, date_range)
      selected_room = find_room(room_id)
      reservations_room_date = selected_room.bookings.reject{|reservation|false == reservation.date_range.overlapping(date_range)}
      return reservations_room_date    
    end


    def find_reservations_range(given_range)
      reservations_range = []

      rooms.each do |room|
        room.bookings.each do |reservation|
          reservations_range << reservation if reservation.date_range.overlapping(given_range)
        end
      end

      return reservations_range
    end


    def find_available_rooms(given_range)
      available_rooms = []
      
      rooms.each do |room|
        if room.bookings.empty?
          available_rooms << room
        else
          status = true
          room.bookings.each do |item|
            if item.block >= 0  #item.class == Hotel::Block 
              status = false if item.date_range.overlapping(given_range) && false == item.date_range.exactly_matching(given_range) #it is not an exact match #method
            elsif item.block < 0  #item.class == Hotel::Reservation
              status = false if item.date_range.overlapping(given_range)
            end
          end
          available_rooms << room if true == status
        end
      end

      raise NoAvailabilityError.new "No Availability. Please try another date range." if available_rooms == []
      return available_rooms
    end

       
    def make_reservation(start_date, end_date)
      range_created = Hotel::DateRange.new(start_date,end_date)
      available_rooms = find_available_rooms(range_created)
      
      chosen_room = available_rooms.shift
      new_reservation = Hotel::Reservation.new(range_created, chosen_room.room_id)
 
      chosen_room.add_booking_to_room(new_reservation)

      return new_reservation
    end


    def find_block_rooms(given_range)
      available_rooms = rooms.reject do |room|
        room.bookings.any? do |reservation|   #returns true if there are overlapping reservations
          reservation.date_range.overlapping(given_range) == true
        end
      end
      return available_rooms
    end


    def make_specific_block(date_range, roomid_array, cost)
      room_array = roomid_array.map{|id| find_room(id)} 
      raise ArgumentError.new "Maximum 5 rooms for a hotel block." if room_array.length > 5 || room_array.length == 0
      rooms_in_block = []

      room_array.each do |room|
        if room.is_available(date_range) == false
          raise NoAvailabilityError.new "Room#{room.room_id} is not available for this given date range."
        end
      end

      room_array.each do |room|
        room_block = Hotel::Block.new(date_range,room.room_id, cost, @@next_block)
        room.add_booking_to_room(room_block)
        rooms_in_block << room_block
      end

      @@next_block += 1
      
      return rooms_in_block
    end


    def make_block(date_range, room_quantity, cost)
      raise ArgumentError.new "Maximum 5 rooms for a hotel block." if room_quantity > 5
      available_rooms = find_block_rooms(date_range)
      raise NoAvailabilityError.new "No availability. Please try another date range." if available_rooms.length < room_quantity

      rooms_in_block = []

      room_quantity.times do |i|
        chosen_room = available_rooms[i]
        room_id = chosen_room.room_id
        room_block = Hotel::Block.new(date_range,room_id, cost, @@next_block)
        chosen_room.add_booking_to_room(room_block)
        rooms_in_block << room_block
      end

      @@next_block += 1 
      return rooms_in_block
    end


    def find_room(given_room_id)
      room_found = rooms.find{|room|room.room_id == given_room_id}
      return room_found
    end
   
    
    def check_block_availability(block_id)
      rooms_in_block = []
      blocks = []
      rooms.each do |room|
        room.bookings.each do |item|
          if item.block > 0 && item.block == block_id
            blocks << item
            rooms_in_block << room
          end
        end
      end

      date_range = blocks[0].date_range
      rooms_in_block.any?{|room|room.is_available(date_range)} #returns true or false
    end
  end
end
