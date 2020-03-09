require 'date'
require_relative 'reservation'
require_relative 'calendar_date'
require_relative 'room'

class Calendar

  def initialize
    @date_store = {}
    @all_reservation_store = []
  end


  def make_reservation(start_date, end_date)
    reservation = Reservation.new(start_date, end_date)
    return reservation
  end


  def list_of_available_rooms_entire_stay(reservation)
    date_range = []
    available_rooms_all_dates = []

    reservation.total_nights.times do |i|
      date_range << (reservation.start_date + i).available_rooms
      raise NoRoomError.new "There are no rooms available for the duration of this stay." if (reservation.start_date + i).unavailable?
    end

    date_range.each do |i, j|
      if (date_range[0] & date_range[i]).any?
        available_rooms_all_dates << (date_range[0] & date_range[i])
      end
    end

    raise NoRoomError.new "There are no rooms available for the duration of this stay." if available_rooms_all_dates.empty?   

    return available_rooms_all_dates.flatten.uniq!
  end


  def is_available?(room_number, date)
    return @date_store[date].available_rooms(room_number)
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
    @all_reservation_store << reservation

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