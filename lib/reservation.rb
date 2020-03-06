require_relative "date_range"

class Reservation < Date_Range
  attr_accessor :room_num, :check_in_date, :check_out_date

  def initialize(room_num, check_in_date, check_out_date)
    @room = room_num
    @check_in_date = check_in_date
    @check_out_date = check_out_date
  end

  #each time the employee creates a reservation it is created here

# Every room is identical, and a room always costs $200/night
  def total_cost_for_stay
    number_of_nights? * 200
  end
end

#  take in the Room class add_res method, converts date range into number of nights, each night * $200 less the one night
#   def number_of_nights?
#     @room.add_reservation(check_in_date, check_out_date)
#     num_of_nights = check_out_date - check_in_date - 1
#     return num_of_nights.to_i
#   end

#   def total
#     total_cost_for_stay = number_of_nights? * 200
#     return total_cost_for_stay
#   end
