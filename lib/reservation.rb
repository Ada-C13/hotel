require 'date'

require_relative 'date_range'
require_relative 'room'

module Hotel
  class Reservation
    attr_reader :reservation_id, :dates, :occupancy 

    def initialize(type, dates, occupancy)
      @reservation_id = type[0] + dates.to_id + occupancy[:room_id]
      @dates = dates
      @occupancy = occupancy
    end

    def total_price 
      return @dates.duration * @occupancy[room.price]
    end

  end
end
