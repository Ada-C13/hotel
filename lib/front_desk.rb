require_relative 'reservation'
require_relative 'date_range'

module Hotel
  class FrontDesk
    attr_accessor :reservations, :rooms, :calendar

    def initialize
      @rooms = (1..20).map { |i| i }
      @reservations = []
      @calendar = {}
    end

    def populate_calendar(reservation)
      temp = reservation.date_range.dates
      temp.pop
      temp.each do |date|
        if !@calendar.key?(date)
          @calendar[date] =[]
        end
        @calendar[date] << reservation
      end
      return @calendar
    end

    # User: I can access the list of all of the rooms in the hotel
    def list_rooms
      return @rooms
    end

    # User: I can make a reservation of a room for a given date range, and that room will not be part of any other reservation overlapping that date range
    # User: I want an exception raised if I try to reserve a room during a date range when all rooms are reserved, so that I cannot make two reservations for the same room that overlap by date

    def reserve_room(requested_dates)
       available_rooms = available_rooms(requested_dates)
       book_room = available_rooms.first
       new_reservation = Hotel::Reservation.new(
        room: book_room, 
        date_range: requested_dates,
      )
      @reservations.push(new_reservation)
      populate_calendar(new_reservation)
      return new_reservation
    end

    # User: I can access the list of reservations for a specific date, so that I can track reservations by date
    def date_reservations(date)
      # ! TODO check if date is empty & raise argument error
      # ! TODO check if date is date & raise argument error
      date_resv = @calendar[date]
      return date_resv
    end

    # User: I access the list of reservations for a specified room and a given date range
    
    # returns an array of reservations for requested dates
    def range_reservations(requested_dates)
      range_resv = []
      requested_dates.dates.each do |date|
        if @calendar.key?(date)
          range_resv.push(*@calendar[date])
        end
      end
      range_resv = range_resv.uniq
      return range_resv
    end

    # search an array of reservations and return only the reservations for the specified room
    def find_room_res(room_num, range_resv)
      room_res = []
      range_resv.each do |res|
        if res.room == room_num
          room_res.push(res)
        end
      end
      room_res = room_res.uniq
      return room_res
    end


    # Wave 2

    # User: I can view a list of rooms that are not reserved for a given date range, so that I can see all available rooms for that day
    def available_rooms(requested_dates)
      occupied_rooms = []
      select_res = range_reservations(requested_dates)

      select_res.each do |reservation|
        occupied_rooms << reservation.room 
      end 

      empty_rooms = [] 
      @rooms.each do |room|
        unless occupied_rooms.include?(room)
          empty_rooms << room
        end 
      end 
      empty_rooms = empty_rooms.uniq
      return empty_rooms 
    end 
  end
end
