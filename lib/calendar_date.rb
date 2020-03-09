require 'date'
require_relative 'room'

class CalendarDate

  def initialize
    @day_reservation_store = []
    @available_rooms = Rooms.new
  end

  def reservations 
    return @day_reservation_store
  end

  def unavailable?
    return @reservation_store.length == 20 
  end

  def available_rooms
    return @available_rooms.rooms  
  end

  def assign_room_number(reservation)
    @available_rooms
    reservation.total_nights.do |i|
      raise NoRoomError "There are no rooms available on the given date." if (resevervation.start_date + i).unavailable?


  end

  
  def add_reservation(reservation)
    @reservation_store << reservation.reservation_details
    @available_rooms.room_reserved(reservation.room_number)

    return @day_reservation_store
  end

end