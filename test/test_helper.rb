require "simplecov"
SimpleCov.start

require "minitest"
require "minitest/autorun"
require "minitest/reporters"
require "minitest/skip_dsl"

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

# require_relative your lib files here!
# test/test_helper.rb
# require_relative "/lib/hotel_block.rb"
# require_relative "/lib/date_range.rb"
# require_relative "/lib/hotel_dispatch.rb"
# require_relative "/lib/reservation.rb"
