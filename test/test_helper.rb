# Add simplecov
require 'simplecov'
SimpleCov.start do
  add_filter 'test/' # Tests should not be checked for coverage.
end
require "minitest"
require "minitest/autorun"
require "minitest/reporters"
require 'minitest/skip_dsl'
require 'date'


require 'minitest/pride'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

# require_relative your lib files here!

require_relative '../lib/hotel_manager'
require_relative '../lib/reservations'
require_relative '../lib/room'
