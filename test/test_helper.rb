# simplecov syntax
require 'simplecov'
SimpleCov.start do
  add_filter 'test/' # tests should not be checked for coverage
end

# gem requirements
require 'time'
require "minitest"
require "minitest/autorun"
require "minitest/reporters"

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

# require_relative your lib files here!
require_relative '../lib/reservation'
require_relative '../lib/date_range'
require_relative '../lib/front_desk'