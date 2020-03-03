require "date"
require_relative "test_helper"

describe "Reservation class" do
  describe "Reservation instantiation" do
    before do
      date_range = Hotel::DateRange.new(start_date: Date.new(2020, 2, 24), end_date: Date.new(2020, 2, 25))
      @reservation = Hotel::Reservation.new(date_range: date_range, room: 1)
    end
    it "is an instance of Reservation" do
      expect(@reservation).must_be_kind_of Hotel::Reservation
    end
    # tests for validating each parameter: date_range:, cost:, room:
    it "stores an instance of DateRange" do
      expect(@reservation.date_range).must_be_kind_of Hotel::DateRange
    end
    it "has a room" do
      expect(@reservation.room).must_be_kind_of Integer
    end
  end
  describe "calculate_cost" do
    before do
      date_range = Hotel::DateRange.new(start_date: Date.new(2020, 2, 24), end_date: Date.new(2020, 2, 25))
      @reservation = Hotel::Reservation.new(date_range: date_range, room: 1)
    end
    it "calculates cost correctly" do
      expect(@reservation.calculate_cost).must_equal 200
    end
  end
end
