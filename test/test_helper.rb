require "simplecov"
# SimpleCov.start
require "minitest"
require "minitest/autorun"
require "minitest/reporters"
require "minitest/skip_dsl" # fixes phantom skip (Minitest bug) 
require 'minitest/pride'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

require_relative "../lib/room.rb"
