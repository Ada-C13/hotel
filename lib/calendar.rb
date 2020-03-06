require 'date'
require_relative 'reservation'

class Calendar

  def initialize
    @date_store = {}
    @reservation_store = []
  end

  def make_reservation(start_date, end_date)
    return 4
  end

  def is_available(room_number, dates)
    return 3
  end

  def reservations_on_date(date)
    reservations = @date_store[date] 
    return reservations
  end

  def find_by_id(reservation_id)
    id = @reservation_store.find { |reservation| reservation.id === reservation_id}
    if id == nil
      raise NoReservationError.new("There is no existing reservation with given ID.")
    end
    
    return id
  end

  def total_cost_reservation(reservation_id)
    reservation = find_by_id(reservation_id)
    return reservation.cost
  end

  def add_to_calendar(reservation)
    @reservation_store << reservation

    if !@date_store.key?(reservation.start_date)
      reservation.total_nights.times do |i|
        i += 0 
        @date_store[(Date.parse(reservation.start_date) + i).iso8601] = []
        @date_store[(Date.parse(reservation.start_date) + i).iso8601][reservation.room_number] = reservation  
      end
  
    elsif @date_store.key?(reservation.start_date)
      reservation.total_nights.times do |i|
        i += 0 
        if !@date_store.key?((Date.parse(reservation.start_date) + i).iso8601)
          @date_store[(Date.parse(reservation.start_date) + i).iso8601]= []
          @date_store[(Date.parse(reservation.start_date) + i).iso8601][reservation.room_number] = reservation 

        else 
          if reservation.start_date.length == 20
            raise NoRoomError.new ("There are no available rooms for the duration of specified dates.")
          end
          @date_store[(Date.parse(reservation.start_date) + i).iso8601][reservation.room_number] = reservation 
        end
      end
    end
  end

end