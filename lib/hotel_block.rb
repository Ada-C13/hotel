require 'pry'

require_relative 'room'
require_relative 'reservation'
require_relative 'date_range'

module Hotel
  class HotelBlock < Reservation
    attr_reader :rooms, :date_range, :cost, :available_rooms, :reserved_rooms

    def initialize(discounted_rate:, **args)
      super(**args)
      raise ArgumentError, "5 rooms maximum for a hotel block" if @rooms.length > 5
      @cost = date_range.days * discounted_rate * @rooms.length
      @available_rooms = @rooms
      @reserved_rooms = []
    end

    def book_room(room)
      valid_room = validate_room(room)
      @available_rooms.delete(valid_room)
      @reserved_rooms << valid_room
      return true
    end

    def validate_room(room)
      unless @available_rooms.include?(room)
        raise ArgumentError, "Room not found in Hotel Block"
      end
      return room
    end
  end
end
