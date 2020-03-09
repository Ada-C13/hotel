require 'date'
require_relative 'reservation'
require_relative 'calendar_date'

class Calendar

  def initialize
    @date_store = {}
    @all_reservation_store = []
  end

  def make_reservation(start_date, end_date)
    reservation = Reservation.new(start_date, end_date)
    return reservation
  end

  def is_available(room_number, date)
    if @date_store[date].available_rooms(room_number)
    return 
  end

  def reservations_on_date(date)
    return @date_store[date].reservations
  end

  def rooms_on_date(date)
    if @date_store[date].nil?
      date = CalendarDate.new
    else
      date = @date_store[date]
    end

    raise NoRoomError.new("There are no available rooms on the specified date.") if date.unavailable?

    return date.available_rooms 
  end

  def find_by_id(reservation_id)
    id = @all_reservation_store.find { |reservation| reservation.id === reservation_id}
    raise NoReservationError.new("There is no existing reservation with given ID.") if id == nil
    
    return id
  end

  def total_cost_reservation(reservation_id)
    reservation = find_by_id(reservation_id)
    return reservation.cost
  end

  def add_to_calendar(reservation)
    @all_reservation_store << reservation.reservation_details

    reservation.total_nights.times do |i|
      if !@date_store.key?(reservation.start_date)
        date = CalendarDate.new
        date.add_reservation(reservation)
        @date_store[(reservation.start_date + i)] = date
      else
        @date_store[(reservation.start_date + i)].add_reservation(reservation)
      end
    end
  end
end