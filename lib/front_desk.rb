require "date"
require_relative "date_range"
require_relative "reservation"

module Hotel
  class FrontDesk
    attr_reader :reservations
    
    # Wave 1
    # You might want to replace this method with an attr_reader
    def rooms
      rooms = []
      20.times do |index|
        rooms << index + 1
      end
      return rooms
    end

    def reserve_room(start_date, end_date)
      # start_date and end_date should be instances of class Date
      # reserve = Hotel::DateRange(start_date, end_date)
      
      return Reservation.new(start_date, end_date, nil)
    end

    # def reservations(date)
    #   return []
    # end
  end
end

a = Hotel::FrontDesk.new
p a.rooms