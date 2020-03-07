require "date"
require "awesome_print"
require_relative "date_range"
require_relative "reservation"
require_relative "front_desk"

a = Hotel::FrontDesk.new
# a = Hotel::DateRange.new("2020-03-05", "2020-03-10")
# b = Hotel::DateRange.new("2020-03-10", "2020-03-15")
# p b.overlap_exclude_last?(a)
# date1 = Hotel::DateRange.new("2020-03-05", "2020-03-10")
# date2 = Hotel::DateRange.new("2020-03-20", "2020-03-25")
a.reserve_room("2020-03-05", "2020-03-10")  
a.reserve_room("2020-03-05", "2020-03-10") 
a.reserve_room("2020-03-10", "2020-03-20")  

# a.add_reservation(reservation1)
# a.add_reservation(reservation2)
# # p reservation2.room_num
ap a.reservations
# ap a.check_reservations_in_date_range("2020-03-09", "2020-03-20")  
# # p a.reservations


# # a = Hotel::FrontDesk.new
# # a.reserve_room("2020-3-20", "2020-3-22")
# # check_reservations("2020-3-20")
# # a.check_reservations("2020-2-14")