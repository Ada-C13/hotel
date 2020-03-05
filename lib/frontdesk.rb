require_relative 'reservation.rb'

module Hotel
  class FrontDesk
    
    attr_reader :all_reservations, :rooms
    
    def initialize
      @all_reservations = all_reservations || []
      @rooms = [*1..20]
    end

    def assign_room(new_reservation)
      taken_rooms = []
      all_rooms = @rooms
      @all_reservations.each do |reservation|
        if reservation.conflict?(new_reservation.start_date, new_reservation.end_date) 
          taken_rooms << reservation.assigned_room
        end
        #return taken_rooms
      end
      room_to_assign = (all_rooms - taken_rooms.flatten)
      return room_to_assign.sample(1)
    end

    def add_reservation(start_date, end_date, num_rooms)
      new_reservation = Hotel::Reservation.new(start_date: start_date, end_date: end_date, num_rooms: num_rooms)
      new_reservation.assigned_room = assign_room(new_reservation)
      @all_reservations << new_reservation
    end

    def find_reservation_by_date(date)
      @all_reservations.select {|reservation| reservation.contains(date)}
    end

    def find_available_room_by_date(date)
      taken = []
      all_rooms = @rooms
      booked = @all_reservations.select {|reservation| reservation.contains(date)}
      #puts booked
      booked.each do |reservation|
        taken << reservation.assigned_room
      end
      #puts taken
      #puts taken
      available_rooms = (all_rooms - taken.flatten)
      #puts available_rooms
    end
  end
end