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
    # Returns: Reservation object and also adds it to the grand list of reservations
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
    def find_reservations_by_date(date)
      by_date = @reservations.select { |reservation| reservation.dates.collide?(date,date)}
    end

    def find_reservations_by_room(room)
      #TO DO 
    end

    def find_all_available 
      # TO-DO return all available rooms for a given date range
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