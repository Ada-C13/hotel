
module Hotel
  class ReservationManager
    attr_reader :all_rooms, :all_reservations

    def initialize
      @all_rooms = Hotel::Room.all
      @all_reservations = Array.new
    end
  end
end