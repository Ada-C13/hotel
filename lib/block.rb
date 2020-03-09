require 'date'

require_relative 'date_range.rb'
require_relative 'room.rb'
require_relative 'reservation.rb'

module Hotel
  class Block < Reservation
    attr_reader :start_date, :end_date, :date_range, :disc_rate, :available_rooms, :reserved_rooms

    def initialize(start_date, end_date, collection_of_rooms, disc_rate)
      super(start_date,end_date)
      @date_range = get_date_range(start_date, end_date)
      @collection_of_rooms = collection_of_rooms
      @disc_rate = disc_rate
      @available_rooms = collection_of_rooms
      @reserved_rooms = []
    end

    def reserve_room_from_block(room)
      raise RuntimeError.new("room is not available in hotel block") unless @available_rooms.include?(room)

      @available_rooms.delete(room)
      @reserved_rooms.push(room)
    end



  end
end