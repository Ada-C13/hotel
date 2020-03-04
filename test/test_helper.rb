# Add simplecov
require "simplecov"
SimpleCov.start do
  add_filter 'test/'
end
require "minitest"
require "minitest/autorun"
require "minitest/reporters"
require "minitest/skip_dsl"


Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

# require_relative your lib files here!
require_relative "../lib/date_range"
require_relative "../lib/front_desk"
require_relative "../lib/reservations"
require_relative "../lib/room"