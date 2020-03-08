# Add simplecov
require 'simplecov'
SimpleCov.start do
  add_filter 'test/'
end

# Add requires
require "date"
require "minitest"
require "minitest/autorun"
require "minitest/reporters"
require 'minitest/skip_dsl'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

# require_relative your lib files here!
