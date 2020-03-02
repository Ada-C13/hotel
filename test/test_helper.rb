require "minitest"
require "minitest/autorun"
require "minitest/reporters"
require 'date'
require 'simplecov'
SimpleCov.start do
  add_filter 'test/'
end

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

require_relative '../lib/date_range'
require_relative '../lib/hotel_block'
require_relative '../lib/reception'
require_relative '../lib/reservation'