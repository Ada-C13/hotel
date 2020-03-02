# Add simplecov
require "minitest"
require "minitest/autorun"
require "minitest/reporters"
require 'simplecov'

SimpleCov.start do
  add_filter 'test/manager_test'
  add_filter 'test/reservation_test'
  add_filter 'test/room_test'
end

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

# require_relative your lib files here!
require_relative '../lib/manager'
require_relative '../lib/reservation'
require_relative '../lib/room'
