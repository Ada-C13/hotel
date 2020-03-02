require "minitest"
require "minitest/autorun"
require "minitest/reporters"
require 'date'
require 'simplecov'
SimpleCov.start do
  add_filter 'test/'
end

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

require_relative 'date_range'
require_relative 'hotel_block'
require_relative 'reception'
require_relative 'reservation'