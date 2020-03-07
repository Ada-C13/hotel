# Add simplecov
require 'simplecov'
SimpleCov.start do
  add_filter 'test/' # Tests should not be checked for coverage.
end

require 'date'
require "minitest"
require "minitest/autorun"
require "minitest/reporters"
require "minitest/skip_dsl"

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

# require_relative your lib files here!
# Place `require_relative` commands for loading application code
#   Example:  require_relative '../lib/customer'
# ...
require_relative '../lib/reservation'
require_relative '../lib/front_desk'
require_relative '../lib/room'
require_relative '../lib/date_range'
require_relative '../lib/hotel_block'
