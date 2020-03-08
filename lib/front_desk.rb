require_relative 'room'
require_relative 'reservation'
require_relative 'date_range'
require_relative 'hotel_block'

module HotelBooking
  class FrontDesk
    attr_reader :rooms, :reservations, :hotel_blocks
    def initialize
      @rooms = create_rooms
      @reservations = []
      @hotel_blocks = []
    end

    def create_rooms
      created_room = []
      (1..20).each do |x| 
        created_room << Room.new(number: x)
      end 
      return created_room
    end

    def create_hotel_block(name, date_range, room_count, discount_rate = 1)
      raise ArgumentError.new("maximum rooms you could reserve for a block are 5") if room_count > 5
      raise ArgumentError.new("the hotel does not have #{room_count} rooms available for that time period") if available_rooms(date_range).length < room_count
      
      hotel_block = HotelBlock.new(name: name, date_range: date_range, room_count: room_count, discount_rate: discount_rate)
      block_rooms = available_rooms(date_range).sample(room_count)
      hotel_block.rooms.push(block_rooms)
      hotel_blocks << hotel_block
      return hotel_block
    end

    def available_rooms(test_range)
      overlapping_rooms = @reservations.select do |res|
        res.date_range.overlap?(test_range)
      end.map do |reservation|
        reservation.room
      end

      @hotel_blocks.each { |block| overlapping_rooms.push(block.rooms) if block.date_range.overlap?(test_range) }
      return @rooms.reject { |room| (overlapping_rooms.include? room) }
    end

    def make_reservation(date_range)
      available_room = available_rooms(date_range).first
      raise.ArgumentError.new("no rooms available in this date") if available_room.nil? 
      reservation = Reservation.new(date_range: date_range, room: available_room)
      @reservations << reservation
      return reservation
    end

    def make_block_reservation(name)
      wanted_block = @hotel_blocks.find { |block| block.name == name }
      raise.ArgumentError.new("there is no such hotel blcok") if wanted_block.nil?

      block_room = (wanted_block.rooms.reject { |b_room| list_room_reservations(b_room, wanted_block.date_range).length != 0 }).first
      raise.ArgumentError.new("all rooms of this block have been reserved") if block_room.nil?
 
      block_reservation = Reservation.new(date_range: wanted_block.date_range, room: block_room, block: wanted_block)
      @rooms.each do |room|
        room.in_block = true if room = block_room
      end
      @reservations << block_reservation
      return block_reservation
    end
  
    #  this instruction was a bit vague: I can make a reservation of a room for a given date range, and that room will not be part of any other reservation overlapping that date range - so I made this method (in case someone just calls and only wants the penthouse) 
    def make_room_reservation(test_range, room)
      overlapping = self.list_room_reservations(room, test_range)
      if overlapping.length != 0
        raise ArgumentError.new("room not available in that date range")
      else
        new_res = Reservation.new(date_range: test_range, room: room)
        @reservations << new_res
        return new_res
      end
    end

    def list_room_reservations(room, test_range)
      return @reservations.select { |reservation| reservation.room == room && reservation.date_range.overlap?(test_range) }
    end

    def list_date_reservations(date)
      date_reservations = []
      @reservations.each do |reservation|
        if reservation.date_range.include?(date)
            date_reservations << reservation
        end
      end
      return date_reservations
    end
   
  end

end
