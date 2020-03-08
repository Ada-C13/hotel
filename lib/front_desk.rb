require "date"
require_relative "date_range"
require_relative "individual_reservation"
require_relative "block_reservation"

module Hotel
  class FrontDesk
    attr_reader :rooms, :reservations
    
    def initialize
      @rooms = (1..20).map {|num| num}
      @reservations = {}
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
          if reservation.date_range.overlap_include_last? date_range
            lists << reservation
          end
        end
      end
      return lists
    end

    def is_room_avaiable_for_entire_date_range?(date_range, room_num) # (instance, num)
      if @reservations[room_num] == nil
        return true
      else
        @reservations[room_num].each do |reservation|
          if reservation.date_range.overlap_exclude_last? date_range
            return false
          else
            return true
          end
        end
      end
    end

    def available_rooms(start_date, end_date)
      date_range = Hotel::DateRange.new(start_date, end_date)
      available_rooms = []
      @rooms.each do |room|
        if is_room_avaiable_for_entire_date_range?(date_range, (room))
          available_rooms << (room)
        end
      end
      return available_rooms
    end

    def reserve_room(start_date, end_date)
      date_range = Hotel::DateRange.new(start_date, end_date)

      room_num = available_rooms(start_date, end_date)
      raise StandardError.new("There's no available room in this date range!") if room_num.length == 0

      reservation = Hotel::IndividualReservation.new(
        date_range = date_range, 
        room_num = room_num.first
      )
      add_reservation(reservation)
      return reservation
    end

    def add_reservation(reservation)
      if !(@reservations.key?(reservation.room_num))
        @reservations[reservation.room_num] = [reservation]
      else
        @reservations[reservation.room_num] << [reservation]
      end
      return @reservations[reservation.room_num] # return a list of reservations of that specific room number
    end

    def reserve_block(name, start_date, end_date, num_of_rooms, discount_rate)
      raise StandardError.new("A block can only contain a maximum of 5 rooms! (got #{num_of_rooms})") if num_of_rooms > 5

      blocks = []
      num_of_rooms.times do |time|
        date_range = Hotel::DateRange.new(start_date, end_date)
        room_num = available_rooms(start_date, end_date)
        raise StandardError.new("There's no available room in this date range!") if room_num.length == 0
        block_reservation = Hotel::BlockReservation.new(
          name = name, 
          date_range = date_range, 
          room_num = room_num.first, 
          discount_rate = discount_rate, 
          status = :AVAILABLE
        ) 
        blocks << block_reservation
        add_reservation(block_reservation)
      end
      return blocks
    end

    def reserve_room_in_block(blocks, room_num)
      blocks.each do |block|
        if block.room_num == room_num
          return block.change_room_status
        else
          raise ArgumentError.new("Room #{room_num} isn't an options in the block")
        end
      end
    end
  end
end
