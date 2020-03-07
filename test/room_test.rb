require_relative 'test_helper'
require 'simplecov'

SimpleCov.start do
  add_filter 'test/manager_test'
  add_filter 'test/reservation_test'
  add_filter 'test/room_test'
end

describe "room" do 
  describe "initialze" do 
    it "creates an instance of Room" do 
      room = Hotel::Room.new(rm_num: 3)
      room.must_be_kind_of Hotel::Room
    end 

    it "verifies rm_num is valid" do
    rm_num = 3
    room = Hotel::Room.new(rm_num: rm_num)
    room.must_respond_to :rm_num
    room.rm_num.must_be_instance_of Integer
    room.rm_num.must_equal rm_num
    end

    it "raises argument error if invalid rm_num" do 
      expect{Hotel::Room.new(rm_num: -3)}.must_raise ArgumentError
      expect{Hotel::Room.new(rm_num: nil)}.must_raise ArgumentError
    end 
  end 

  describe "is_available" do 
    it "checks if a room is available on a given date" do 
      # expect if room has no reservations returns true
      # expect if not available returns false 
      # expect if available returns true 
      # invalid date returns argument error?
    end 
  end 

  describe "book_room" do 
    it "correctly makes a reservation for available room" do 
      # expect new instance of Reservation is created
    end 
  end 

end