# Add simplecov
require "minitest"
require "minitest/autorun"
require "minitest/reporters"
require "minitest/skip_dsl"

require 'simplecov'
SimpleCov.start

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

# require_relative your lib files here!

require_relative '../lib/reservation.rb'
require_relative '../lib/frontdesk.rb'
