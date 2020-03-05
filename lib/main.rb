require "date"
require_relative "date_range"
require_relative "reservation"
require_relative "front_desk"

# p Hotel::FrontDesk.new
a = Hotel::DateRange.new("2020-03-05", "2020-03-10")
b = Hotel::DateRange.new("2020-03-10", "2020-03-15")
p b.overlap?(a)


# a = Hotel::FrontDesk.new
# a.reserve_room("2020-3-20", "2020-3-22")
# check_reservations("2020-3-20")
# a.check_reservations("2020-2-14")