# I need a hotel_controller to be able to:
# x create 20 rooms
# control the business logic of adding/ finding reservations
# create Date_Range
# validate Date_Range
# get_reservations(date)
# find_available_room

# From class with Chris:
# For checking available rooms:
# - What if there are no reservations? (it should return a list of all the rooms - All are available. )
# - Do reservations that don't overlap the date range affect the list?
#   Feb 3 - Feb 10 , we can ignore reservations that don't overlap.
# - Boundaries as an overlap - What about a reservation that ends on the checkin date, or starts on the checkout date?
#   1. Consider a date range as a list of dates
#     Compare to see if they have the same dates in the list (O(n) for each reservation)
#   2. Consider a date range as a line with start and end dates
#     Compare the start and end dates
#     If start_1 is greater than start_2 and less than end_2
#             OR 
#     If end_1 is greater than start_2 and less than end_2
# - What if there are no vacancies - Return empty array. Or Exception could be raised. Rescue to say put in new date range?
# - What if your date range spans several small reservations? Remove those smaller spans from the list of available rooms

# - Take the date range of potential reservation, check collection of one room's reservations, if available 
# - if empty, raise Exception. 

# setting the costs/ discounts for rooms


module Hotel
  class Hotel::Controller
    attr_accessor :all_reservations
    attr_reader :rooms
    # hotel_controller needs to have a list of all its reservations,
    # initialized as empty array to begin
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