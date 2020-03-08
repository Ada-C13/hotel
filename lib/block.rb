require 'date'

require_relative 'date_range.rb'
require_relative 'room.rb'
require_relative 'reservation.rb'

module Hotel
  class Block < Reservation
    attr_reader

    def initialize(start_date, end_date, collection_of_rooms, disc_rate)
      super(start_date,end_date)
      @date_range = get_date_range(start_date, end_date)
      @collection_of_rooms = collection_of_rooms
      @disc_rate = disc_rate
    end


  end
end