require_relative 'test_helper'
require 'simplecov'

SimpleCov.start do
  add_filter 'test/manager_test'
  add_filter 'test/reservation_test'
  add_filter 'test/room_test'
end

describe "manager" do 
  it "contains infromation" do 
    STEPHANIE.must_equal 1
  end 

  it "calls creates_rooms" do 
    all_rooms = Hotel::Manager.new
    expect(@all_rooms.length).must_equal 20
  end 

end