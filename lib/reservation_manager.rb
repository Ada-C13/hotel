require 'time'

require_relative 'room'
require_relative 'reservation'

module Hotel
  class ReservationManager
    attr_reader :rooms, :reservations

    def initialize(room_count)
      @rooms = generate_rooms(room_count)
      @reservations = []
    end

    def create_reservation(type, range, guest)
      raise ArgumentError.new("Invalid reservation type (given #{type}, must be :SINGLE or :BLOCK)") unless 
        type == :SINGLE || type == :BLOCK

        occupancy = [{:room => @rooms.sample, :guest => guest}]

      new_reservation = Reservation.new(type, range, occupancy)
      @reservations << new_reservation
      return new_reservation
    end

    def find_reservations_by_date(date)
      by_date = @reservations.select { |reservation| reservation.dates.collide?(date,date)}
    end

    private 

    def generate_rooms(room_count)
      rooms = []
      room_count.times do |num|
        rooms << Room.new(num+1)
      end
      return rooms
    end
  end
end