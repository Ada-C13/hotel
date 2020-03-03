# Add simplecov
require "minitest"
require "minitest/autorun"
require "minitest/reporters"
require "date"

require 'simplecov'
SimpleCov.start do 
  add_filter 'test/'
end 

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

# require_relative your lib files here!