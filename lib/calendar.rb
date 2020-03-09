require 'date'
require_relative 'reservation'
require_relative 'calendar_date'
require_relative 'room'

class Calendar
  attr_accessor :all_reservations_store, :date_store
  
  def initialize
    @date_store = {}
    @all_reservations_store = []
  end


  def make_reservation(start_date, end_date)
    reservation = Reservation.new(start_date, end_date)

    return reservation
  end


  def list_available_rooms_entire_stay(reservation)
    date_range = []
    available_rooms_all_dates = []


    if (reservation.total_nights == 1) && (@date_store[(reservation.start_date).iso8601].all_available_rooms.length == 20)
      available_rooms = [1]
      return available_rooms
    end

    (reservation.total_nights).times do |i|
      if @date_store[(reservation.start_date + i).iso8601].nil?
        date = CalendarDate.new
      else
        raise NoRoomsError.new "There are no rooms available for the duration of this stay." if @date_store[(reservation.start_date + i).iso8601].unavailable?
        date_range << (@date_store[(reservation.start_date + i).iso8601]).all_available_rooms
      end

    end


    date_range.each do |i|
      if (date_range[0] & date_range[i]).any?
        available_rooms_all_dates << (date_range[0] & date_range[i])
      end
    end

    raise NoRoomsError.new "There are no rooms available for the duration of this stay." if available_rooms_all_dates.empty?   

    available_rooms = available_rooms_all_dates.flatten.uniq!

    return available_rooms
  end


  def is_available?(room_number, date)
    date = Date.parse(date).iso8601
    return @date_store[date].room_available?(room_number)
  end


  def reservations_on_date(date)
    date = Date.parse(date).iso8601
    return @date_store[date].reservations
  end


  def rooms_on_date(date)
    date = Date.parse(date).iso8601
    if @date_store[date].nil?
      date = CalendarDate.new
    else
      date = @date_store[date]
    end

    raise NoRoomError.new("There are no available rooms on the specified date.") if date.unavailable?

    return date.all_available_rooms 
  end


  def find_by_id(reservation_id)
    reservation = @all_reservations_store.find { |reservation| reservation[:id] == reservation_id}
    raise NoReservationError.new("There is no existing reservation with given ID.") if reservation == nil
    
    return reservation
  end


  def total_cost_reservation(reservation_id)
    reservation = find_by_id(reservation_id)
    return reservation[:cost]
  end


  def add_to_calendar(reservation)
    @all_reservations_store << reservation.details

    reservation.total_nights.times do |i|
      if !@date_store.key?(reservation.start_date)
        date = CalendarDate.new
        date.add_reservation(reservation)
        @date_store[(reservation.start_date + i).iso8601] = date
      else
        @date_store[(reservation.start_date + i).iso8601].add_reservation(reservation)
        raise NoRoomError.new "Sorry, there is no availability on that date." if @date_store[(reservation.start_date + i).iso8601].unavailable?
      end
    end
  end
end