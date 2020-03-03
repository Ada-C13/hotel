require_relative 'room'

module Hotel
  class SystemCoordinator    
    attr_reader :rooms
    # SystemCoordinator should know rooms

    def initialize
      @rooms = Array.new(20){|i| Hotel::Room.new(i+1)} #access the list of all of the rooms in the hotel
    end

    

    # # many methods
    # # method to make reservation
    # def make_reservation(date_range)
    # end

    # [method] track reservation by date to find list of reservations by date
    # [method] access the list of reservations for a specified room and a given date range
    
    # [method] avail rooms for that day. I can view a list of rooms that are not reserved for a given date range

    # handle/ rescue exceptions when there is no availability


  end
end