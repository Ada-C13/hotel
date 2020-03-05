require_relative 'test_helper'
require 'simplecov'

SimpleCov.start do
  add_filter 'test/manager_test'
  add_filter 'test/reservation_test'
  add_filter 'test/room_test'
end

describe "reservation" do 
  describe "initialze" do 
    it "creates an instance of Reservation" do 
      reservation = Hotel::Reservation.new(start_date: "3/4/2014", end_date: "7/4/2014")
      reservation.must_be_kind_of Hotel::Reservation
    end 

    it "verifies start & end date are valid" do 
      res = Hotel::Reservation.new(start_date: "3/4/2014", end_date: "7/4/2014")
      res.must_respond_to :start_date
      res.must_respond_to :end_date
      res.start_date.must_be_instance_of Date 
      res.end_date.must_be_instance_of Date 
      res.start_date.must_equal Date.new(2014, 4, 3)
      res.end_date.must_equal  Date.new(2014, 4, 7)
    end
    
    it "accepts value for rm_num" do
      res = Hotel::Reservation.new(start_date: "3/4/2014", end_date: "7/4/2014", rm_num: 4)
      res.must_respond_to :rm_num
    end
    
    it "calculates the correct cost" do 
      res = Hotel::Reservation.new(start_date: "3/4/2014", end_date: "7/4/2014")
      res.cost_per_day.must_equal 200
      res.total_cost.must_equal 800
    end
    
    it "makes a recloc" do 
      res = Hotel::Reservation.new(start_date: "3/4/2014", end_date: "7/4/2014")
      res.recloc.must_be_instance_of String
      res.recloc.length.must_equal 6
    end 
  end

  describe "conflict" do 
    it "returns true if there is no conflict" do 
      res = Hotel::Reservation.new(start_date: "3/4/2014", end_date: "7/4/2014")
      
    end
    it "returns false if there is a conflict" do 
      res = Hotel::Reservation.new(start_date: "3/4/2014", end_date: "7/4/2014")
    end 
  end 
end