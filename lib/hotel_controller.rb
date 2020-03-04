# I need a hotel_controller to be able to:
# create 20 rooms
# control the business logic of adding/ finding reservations
# setting the costs/ discounts for rooms

module Hotel
  class Hotel::Controller
    attr_accessor :all_reservations
    attr_reader :rooms
    # hotel_controller needs to have a list of all its reservations,
    # initialized with nil to begin
    def initialize
      create_rooms
      @all_reservations = []
    end

    # Wave 1, US 2: "I can reserve a room for a given date range, so that I can make a reservation"
    def reserve_with_range(input_range)
      # preliminary fulfillment of basic functionality with no conflict-checking or available room searching
      available_room_id = 5
      new_reservation = Hotel::Reservation.new(input_range, available_room_id)
      @all_reservations << new_reservation
      return new_reservation
    end

    # Wave 1, US 3: "I can access the list of reservations for a specific date, so that I can track reservations by date"
    def find_by_date(input_range)
      reservations_by_date = []
      @all_reservations.each do |reservation|
        if input_range == reservation.date_range
          reservations_by_date << reservation
        end
      end
      return reservations_by_date
    end


    private

    # since we're not reading from csv, no need to have a validate_id method?
    # Wave 1, US 1: "I can access the list of all of the rooms in the hotel"
    def create_rooms
      @rooms = (1..20).map do |id|
        Hotel::Room.new(id)
      end
    end
    
  end
end