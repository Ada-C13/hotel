# Add simplecov
require "minitest"
require "minitest/autorun"
require "minitest/reporters"
require "simplecov"
SimpleCov.start do
  add_filter 'test/'
end

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

# require_relative your lib files here!
require_relative "../lib/calendar"
require_relative "../lib/front_desk"
require_relative "../lib/reservations"
require_relative "../lib/rooms"