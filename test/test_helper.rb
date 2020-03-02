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
# Place `require_relative` commands for loading application code
#   Example:  require_relative '../lib/customer'
# ...
require_relative '../lib/reservation'