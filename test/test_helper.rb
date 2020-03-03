require 'simplecov'
SimpleCov.start do
	add_filter 'test/' # Tests should not be checked for coverage
end

require 'minitest'
require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

# require_relative your lib files here!
require_relative '../lib/reservation'
require_relative '../lib/front_desk'

# In other test files, we will require_relative 'test_helper'