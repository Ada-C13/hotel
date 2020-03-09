require_relative 'test_helper'
require 'simplecov'

SimpleCov.start do
  add_filter 'test/manager_test'
  add_filter 'test/reservation_test'
  add_filter 'test/room_test'
end

describe "room" do 
  before do 
    @room1 = Hotel::Room.new(rm_num: 1)
    @room2 = Hotel::Room.new(rm_num: 2)
    @room1.book_room(Date.new(2014, 4, 3), Date.new(2014, 4, 7))
    @room1.book_room(Date.new(2014, 4, 1), Date.new(2014, 4,2))
  end

  describe "initialze" do 
    it "creates an instance of Room" do 
      @room1.must_be_kind_of Hotel::Room
    end 
    
    it "verifies rm_num is valid" do
      rm_num = 3
      room = Hotel::Room.new(rm_num: rm_num)
      room.must_respond_to :rm_num
      room.rm_num.must_be_instance_of Integer
      room.rm_num.must_equal 3
    end
    
    it "raises argument error if invalid rm_num" do 
      expect{Hotel::Room.new(rm_num: -3)}.must_raise ArgumentError
      expect{Hotel::Room.new(rm_num: nil)}.must_raise ArgumentError
    end 
  end 
  
  describe "is_available" do 
    it "checks if a room is_available on a given date" do 
      expect(@room2.is_available(Date.new(2014, 4, 7))).must_equal true
      expect(@room1.is_available(Date.new(2014, 4, 3))).must_equal false
      expect(@room1.is_available(Date.new(2014, 4, 1))).must_equal false
      expect(@room1.is_available(Date.new(2014, 4, 12))).must_equal true
      expect(@room1.is_available(Date.new(2014, 4, 7))).must_equal true
      expect{@room1.is_available(Date.new(2014, 45, 1))}.must_raise ArgumentError
    end 
  end 
  
  describe "is_available_range" do 
    it "checks if a room is available on a range of dates" do 
      expect(@room2.is_available_range(Date.new(2014, 4, 3), Date.new(2014, 4, 7))).must_equal true
      expect(@room1.is_available_range(Date.new(2014, 3, 25), Date.new(2014, 3, 29))).must_equal true
      expect(@room1.is_available_range(Date.new(2014, 4, 2), Date.new(2014, 4, 3))).must_equal true
      expect(@room1.is_available_range(Date.new(2014, 4, 3), Date.new(2014, 4, 7))).must_equal false
      expect(@room1.is_available_range(Date.new(2014, 3, 25), Date.new(2014, 4, 2))).must_equal false
    end 
  end 

  describe "book_room" do
    before do 
      @room3 = Hotel::Room.new(rm_num: 3)
      @room4 = Hotel::Room.new(rm_num: 4)
    end 

    it "correctly books a reservation" do 
      expect(@room3.book_room(Date.new(2014, 4, 3), Date.new(2014, 4, 7))).must_be_instance_of Hotel::Reservation
    end 

    it "correctly adds new reservation to rm's reservations" do 
      @room4.book_room(Date.new(2014, 3, 25), Date.new(2014, 3, 27))
      @room4.book_room(Date.new(2014, 5, 10), Date.new(2014, 6, 27))
      expect(@room4.rm_reservations.length).must_equal 2
    end 
  end

  describe "has_res_by_date" do
    before do 
      @room1 = Hotel::Room.new(rm_num: 1)
      @room2 = Hotel::Room.new(rm_num: 2)
      @room1.book_room(Date.new(2014, 4, 3), Date.new(2014, 4, 7))
      @room1.book_room(Date.new(2014, 4, 1), Date.new(2014, 4,2))
    end 

    it "returns nil if no reservations" do 
      expect(@room2.has_res_by_date(Date.new(2014, 8, 3))).must_equal false
    end 

    it "returns reservation if it has one" do 
      expect(@room1.has_res_by_date(Date.new(2014, 4, 3))).must_be_instance_of Hotel::Reservation
      expect(@room1.has_res_by_date(Date.new(2014, 8, 3))).must_equal false
    end 
  end 
end