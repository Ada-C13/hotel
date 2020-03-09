require 'date'

require_relative 'room'
require_relative 'reservation'

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


  def available?(room_number)
    return @available_rooms.include?(room_number)
  end


  def all_available_rooms
    return  @available_rooms.rooms
  end

  
  def add_reservation(reservation)
    @day_reservation_store << reservation.reservation_details
    @available_rooms.room_reserved(reservation.room_number)

    return @day_reservation_store
  end

end