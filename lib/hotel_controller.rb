require_relative 'date_range'
require_relative 'reservation'
require_relative 'room'

module Hotel
  class Hotel::Controller
    attr_reader :rooms

    def initialize
      create_rooms
    end

    def find_available_rooms(input_range)
      available = []
      @rooms.each do |room|
        if room.conflict?(input_range) == false
          available << room.room_id
        end
      end

      return available
    end

    def reserve_with_range(input_range)
      @rooms.each do |room|
        return room.room_id if room.create_room_reservation(input_range)
      end

      raise ArgumentError.new("No rooms available for date range.")
    end

    def find_all_within_range(input_range)
      reservations_by_range = []
      @rooms.each do |room|
        reservations_by_range << room.find_by_range(input_range)
      end

      return reservations_by_range.flatten
    end

    def find_by_exact_date(input_range)
      reservations_by_date = []
      @rooms.each do |room|
        filtered_rez = room.find_by_range(input_range)
        filtered_rez.each do |rez|
           if rez.date_range == input_range
             reservations_by_date << rez
             break
           end
        end
      end

      return reservations_by_date
    end

    private

    def create_rooms
      @rooms = (1..20).map do |id|
        Hotel::Room.new(id)
      end
    end
    
  end
end