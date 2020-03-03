# Add simplecov
require "minitest"
require "minitest/autorun"
require "minitest/reporters"

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

require 'simplecov'
SimpleCov.start do
  add_filter 'test/' # Tests should not be checked for coverage.
end

# require_relative your lib files here!
require_relative "../lib/reservation"
require_relative "../lib/date_range"
require_relative "../lib/front_desk"