# Add simplecov
require 'simplecov'
SimpleCov.start do
  add_filter 'test/' # Tests should not be checked for coverage.
end


require "minitest"
require "minitest/autorun"
require "minitest/reporters"

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

# require_relative your lib files here!

require_relative '../lib/data_range'
require_relative '../lib/hotel_controller'
require_relative '../lib/reservation'

