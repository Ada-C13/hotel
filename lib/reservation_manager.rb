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

    # Parameters: 
    # -type: symbol (:SINGLE, :BLOCK) that indicates type of reservation
    # -range: DateRange object 
    # -occupancy: Hash or String
    # Returns: newly created Reservation object
    def create_reservation(type, range, occupancy)
      raise ArgumentError.new("Invalid reservation type (given #{type}, must be :SINGLE or :BLOCK)") unless 
        type == :SINGLE || type == :BLOCK

      occupancy = [{:room => @rooms.sample, :guest => occupancy}] if occupancy.class == String

      new_reservation = Reservation.new(type, range, occupancy)
      @reservations << new_reservation
      return new_reservation
    end

    # Parameters: Date object 
    # Returns: an Array of all Reservation instances that contain that date
    def find_reservations_by_date(check_in, check_out)
      by_date = @reservations.select { |reservation| reservation.dates.overlap?(check_in, check_out)}
    end

    def find_reservations_by_room(room)
      by_room = @reservations.select { |reservation| reservation.occupancy.detect { |occupancy| occupancy[:room] == room }}
    end

    def list_all_available(check_in, check_out)
      reserved = find_reservations_by_date(check_in, check_out)

      if reserved.length > 0
        occupancies = reserved.map { |reservation| reservation.occupancy }
        occupied_rooms = occupancies.flatten
        occupied_rooms_ids = occupied_rooms.map { |occupancy| occupancy[:room].id }
      end

      rooms = @rooms.map { |room| room.id }

      return (rooms - occupied_rooms_ids)
      
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