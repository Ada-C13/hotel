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

  describe "initialze" do 
    it "creates an instance of Reservation" do 
      reservation = Hotel::Reservation.new(start_date: "3/4/2014", end_date: "7/4/2014")
      reservation.must_be_kind_of Hotel::Reservation
    end 

    it "verifies start & end date are valid" do 
      res = Hotel::Reservation.new(start_date: "3/4/2014", end_date: "7/4/2014")
      res.must_respond_to :start_date
      res.must_respond_to :end_date
      res.start_date.must_be_instance_of Date #?
      res.end_date.must_be_instance_of Date 
    end
    
    it "calculates the correct res length and total_cost" do 
      res = Hotel::Reservation.new(start_date: 3/4/2014, end_date: 7/4/2014)
      res.res_length.must_equal 4
      res.total_cost.must_equal 800
    end
    
    it "" do 

    end 
  end
end