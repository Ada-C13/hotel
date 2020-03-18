require "simplecov"
SimpleCov.start
require "minitest"
require "minitest/autorun"
require "minitest/reporters"
require "minitest/skip_dsl" # fixes phantom skip (Minitest bug) 
require 'minitest/pride'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

require "date"

require_relative "../lib/date_range.rb"
require_relative "../lib/front_desk.rb"
require_relative "../lib/reservation.rb"
require_relative "../lib/room.rb"
