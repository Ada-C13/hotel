require_relative 'reservation'
require_relative 'date_range'
require_relative 'room'

module Hotel 
  class HotelManager 
    attr_reader :rooms, :reservations 

    def initialize(rooms = [])
      20.times do |i| 
        rooms << Hotel::Room.new(i + 1)
      end 

      @rooms = rooms
      @reservations = []
    end 


    def available_room(date_range)
      date_range.valid_dates?

      return @rooms.find { |room| room.vacancy == true }
    end
  end 
end 