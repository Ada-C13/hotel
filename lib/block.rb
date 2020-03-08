require 'date'

require_relative 'date_range.rb'
require_relative 'room.rb'
require_relative 'reservation.rb'

module Hotel
  class Block < Reservation
    attr_reader

    def initialize(date_range, collection_of_rooms, disc_rate)
      raise ArgumentError if date_range.class != Hotel::DateRange

      @date_range = date_range
      @collection_of_rooms = collection_of_rooms
      @disc_rate = disc_rate
    end


  end
end