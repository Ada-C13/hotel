require_relative 'test_helper'
require 'simplecov'

SimpleCov.start do
  add_filter 'test/manager_test'
  add_filter 'test/reservation_test'
  add_filter 'test/room_test'
end

describe "reservation" do 
  it "contains infromation" do 
    TIFFANY.must_equal 1
  end 

end