require 'simplecov'
SimpleCov.start do
  add_filter 'test/' # Tests should not be checked for coverage.
end

require "minitest"
require "minitest/autorun"
require "minitest/reporters"

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

# require_relative your lib files here!
require "./lib/hotel_manager.rb"
require "./lib/reservation.rb"
require "./lib/room.rb"
require "./lib/date_range.rb"
require "./lib/hotel_block.rb"
