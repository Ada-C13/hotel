# I need a hotel_controller to be able to:
# x create 20 rooms
# control the business logic of adding/ finding reservations
# send start/end dates to create instance of DateRanges
# find_reservations(date)
# find_available_room
# room.check_is_available for all rooms

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

require_relative 'date_range'
require_relative 'reservation'
require_relative 'room'

module Hotel
  class Hotel::Controller
    attr_reader :rooms

    def initialize
      create_rooms
    end

    def find_available_rooms(input_range)
      available = []
      @rooms.each do |room|
        if room.conflict?(input_range) == false
          available << room.room_id
        end
      end

      return available
    end

    # Wave 1, US 2: "I can reserve a room for a given date range, so that I can make a reservation"
    def reserve_with_range(input_range)
      @rooms.each do |room|
          # will return false if can't create rez, otherwise will create and add to rez_list and return true
        return room.room_id if room.create_room_reservation(input_range)
      end

      return false
    end

    # Wave 1, US 3: "I can access the list of reservations for a specific date, so that I can track reservations by date"
#  creates an array of matching reservations

    # def find_by_date(input_range)
    #   reservations_by_date = []
    #   @rooms.each do |room|
    #     filtered_rez = room.find_by_range(input_range)
    #     filtered_rez.each do |rez|
    #        if rez.date_range == input_range
    #          reservations_by_date << rez
    #          break
    #        end
    #     end
    #   return reservations_by_date
    # end

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