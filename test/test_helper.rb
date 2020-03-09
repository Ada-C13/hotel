require "simplecov"
SimpleCov.start
require "minitest"
require "minitest/autorun"
require "minitest/reporters"
require "minitest/skip_dsl"
require "date"

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

# Require_relative your lib files here!
require_relative "../lib/hotel_controller.rb"
require_relative "../lib/reservation.rb"
require_relative "../lib/date_range.rb"




# wave 1 user stories

# I can access the list of all of the rooms in the hotel X hotel_controller.rb

# I access the list of reservations for a specified room and a given date range X hotel_controller.rb

# I can access the list of reservations for a specific date, so that I can track reservations by date  

# I can get the total cost for a given reservation  X reservation.rb

# I want exception raised when an invalid date range is provided, 
# so that I can't make a reservation for an invalid date range X


# wave 2 user stories

# I can view a list of rooms that are not reserved for a given date range, 
# so that I can see all available rooms for that day  

# I can make a reservation of a room for a given date range, 
# and that room will not be part of any other reservation overlapping that date range

# I want an exception raised if I try to reserve a room during a date range when all rooms are reserved, 
# so that I cannot make two reservations for the same room that overlap by date

