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
require_relative "../lib/room"
require_relative "../lib/reservation"
require_relative "../lib/res_man"
require_relative "../lib/block_res"