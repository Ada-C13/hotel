require_relative 'test_helper'
require 'date'

describe "Reservation class" do
  describe "#initialize" do
    it "creates an instance of Reservation class" do
      booking = Hotel::Reservation.new(
        room: Hotel::Room.new(1), 
        start_date: "3rd Mar 2020", 
        end_date: "5th Mar 2020")
      expect(booking).must_be_instance_of Hotel::Reservation
    end

    it "raises an Argument Error if check-out is earlier than check-in" do
      expect{
        Hotel::Reservation.new(
        room: Hotel::Room.new(1), 
        start_date: "7th Mar 2020", 
        end_date: "5th Mar 2020")
    }.must_raise ArgumentError
    end

    it "raises an Argument Error if check-out is the same day as check-in" do
      expect{
        Hotel::Reservation.new(
        room: Hotel::Room.new(1), 
        start_date: "5th Mar 2020", 
        end_date: "5th Mar 2020")
    }.must_raise ArgumentError
    end

    it "calculates the cost of reservation, does not count the last day" do
      reservation = Hotel::Reservation.new(
        room: Hotel::Room.new(1), 
        start_date: "3rd Mar 2020", 
        end_date: "5th Mar 2020")
      expect(reservation.cost).must_equal 400
    end

    it "saves correct dates for check-in and check-out" do
      check_in = Date.parse("3rd Mar 2020")
      check_out = Date.parse("4th Mar 2020")

      reservation = Hotel::Reservation.new(
        room: Hotel::Room.new(1), 
        start_date: "3rd Mar 2020", 
        end_date: "5th Mar 2020")
      expect(reservation.start_date).must_equal check_in
      expect(reservation.end_date).must_equal check_out
    end
  end
end
