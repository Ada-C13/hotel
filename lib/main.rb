require "date"
require_relative "date_range"
require_relative "reservation"
require_relative "front_desk"

# p Hotel::FrontDesk.new
# p Hotel::DateRange.new("2020-3-14", "2020-3-15")


a = Hotel::FrontDesk.new
a.reserve_room("2020-3-20", "2020-3-22")
check_reservations("2020-3-20")
# a.check_reservations("2020-2-14")