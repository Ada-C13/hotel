# require 'simple_cov'
require "minitest"
require "minitest/autorun"
require "minitest/reporters"
require 'minitest/skip_dsl'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

# require_relative your lib files here!
# test/test_helper.rb
