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

    def create_hotel_block(date_range, room_count, discount_rate = 1)
      raise ArgumentError.new("maximum rooms you could reserve for a block are 5") if room_count > 5
      raise ArgumentError.new("the hotel does not have #{room_count} rooms available for that time period") if self.available_rooms(date_range).lenght < room_count
      
      hotel_block = HotelBlock.new(date_range: date_range, room_count: room_count, discount_rate: discount_rate)
      block_rooms = self.available_rooms(date_range).sample(room_count)
      rooms.each do |room|
        if block_rooms.include? (room)
          room.in_block = true
        end
      end
      # how do I take the rooms out of the true in block status after the block date has finished?
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

      block_rooms = rooms.select do |room|
        room.in_block == true
      end

      return @rooms.reject do |room|
        (overlapping_rooms.include? room) || (block_rooms.include? room)
      end
    end

    def make_reservation(date_range)
      available_room = self.available_rooms(date_range).first
      raise.ArgumentError.new("no rooms available in this date") if available_room.nil? 
      reservation = Reservation.new(date_range: date_range, room: available_room)
      @reservations << reservation
      return reservation
    end

    # make_block_reservation
    # I can check whether a given block has any rooms available
    # I can reserve a specific room from a hotel block
      # I can only reserve that room from a hotel block for the full duration of the block
    # I can see a reservation made from a hotel block from the list of reservations for that date (see wave 1 requirements)  
    # end
  

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
