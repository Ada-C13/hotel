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

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

# require_relative your lib files here!
require_relative "../lib/block_res.rb"
require_relative "../lib/res_man.rb"
require_relative "../lib/reservation.rb"