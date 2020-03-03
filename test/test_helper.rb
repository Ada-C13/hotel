# Add simplecov
require 'simplecov'
SimpleCov.start
require "minitest"
require "minitest/autorun"
require "minitest/reporters"

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

# require_relative your lib files here!
require_relative 'room'
require_relative 'bookings'
require_relative 'bookingsystem'
