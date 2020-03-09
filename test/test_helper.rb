# Add simplecov
require "simplecov"
SimpleCov.start do
  add_filter 'test/'
end
require "minitest"
require "minitest/autorun"
require "minitest/reporters"
require "minitest/skip_dsl"
require "date"

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

# require_relative your lib files here!
require_relative "../lib/date_range"
require_relative "../lib/front_desk"
require_relative "../lib/reservations"
require_relative "../lib/room"
require_relative "../lib/hotel_block"
require_relative '../lib/No_Available_Room_Error.rb'
