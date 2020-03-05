require "date"

module Hotel
  class HotelController
    attr_reader :rooms, :reservations

    def initialize(rooms:, reservations:)
      @rooms = (1..20).to_a
      @reservations = []
    end

    def make_reservation(check_in:, check_out:)
      date_range = DateRange.new(check_in: check_in, check_out: check_out)
      # if reservations.length > 0, room = find_available_room(date_range), 
      # else room = @rooms[0] for first reservation
      room = @rooms.sample # 
      reservation = Reservation.new(date_range: date_range, room: room)
      @reservations << reservation
      return reservation
    end

    # def find_by_date(reservations)
      # call include? ?
    # end

    # def find_by_date(room, date_range)
      # call include? ?
    # end

    def find_available_room(new_date_range)
      # available_rooms = @rooms.clone
      # pass in new DateRange object, which has a start_date and end_date to compare against... 
      # @reservations.each do reservation.date_range.overlap?(new_date_range)
      # if overlap? returns true, available_rooms.delete(reservation.room)
      # return available_rooms.sample
    end

    # def show_all_rooms
      # @rooms.each |room| do puts "room: " room end
    # end

    # show reservation cost (by what? how? reservation id?)

  end
end
