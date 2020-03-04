require_relative 'test_helper'
require 'simplecov'

SimpleCov.start do
  add_filter 'test/manager_test'
  add_filter 'test/reservation_test'
  add_filter 'test/room_test'
end

describe "manager" do 
  it "creates an instance of Manager" do 
    manager = Hotel::Manager.new
    manager.must_be_kind_of Hotel::Manager
  end 

  it "creates the correct number of rooms" do 
    all_rooms = Hotel::Manager.create_rooms(20)
    expect(all_rooms.length).must_equal 20
  end
  

  it "can make a reservation" do 
  
  end 

  it "can check availability by room" do 

  end 
  

end