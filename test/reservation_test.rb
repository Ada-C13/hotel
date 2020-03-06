require_relative 'test_helper'
require 'date'

describe "Reservation" do
  describe "#initialize" do
    it "Creates an instance of Reservation" do
      start_date = Date.new(2020, 3, 1)
      end_date = Date.new(2020, 3, 5)
  
      date_range = Hotel::DateRange.new(start_date, end_date)
      reservation = Hotel::Reservation.new(date_range, 10)
      expect(reservation).must_be_kind_of Hotel::Reservation
    end

    it "Keeps track of date range" do
      start_date = Date.new(2020, 3, 1)
      end_date = Date.new(2020, 3, 5)
      date_range = Hotel::DateRange.new(start_date, end_date)

      reservation = Hotel::Reservation.new(date_range, 10)
      expect(reservation).must_respond_to :date_range
    end

    it "Keeps track of room" do
      start_date = Date.new(2020, 3, 1)
      end_date = Date.new(2020, 3, 5)
      date_range = Hotel::DateRange.new(start_date, end_date)

      reservation = Hotel::Reservation.new(date_range, 10)
      expect(reservation).must_respond_to :room
    end
  end

  describe "#calculate_total_cost" do
    it "returns total cost for a reservation" do
      front_desk = Hotel::FrontDesk.new
      reservation = front_desk.make_reservation(Date.new(2020, 3, 10), Date.new(2020, 3, 14))
      reservation = reservation[-1]
      puts "reservation is #{reservation.class}"
      puts "total cost is #{reservation.calculate_total_cost}"
      expect(reservation.calculate_total_cost).must_equal 800
    end
  end
end