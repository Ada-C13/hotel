require_relative 'test_helper'

describe "Reservation class" do
  describe "#initialize" do
    it "creates an instance of Reservation class" do
      range = Hotel::DateRange.new(start_date: "2 Mar 2020", end_date: "5 Mar 2020")
      booking = Hotel::Reservation.new(
        rooms: [Hotel::Room.new(1)],
        date_range: range)
      expect(booking).must_be_instance_of Hotel::Reservation
    end

    it "calculates the cost of reservation, does not count the last day" do
      range = Hotel::DateRange.new(start_date: "3 Mar 2020", end_date: "5 Mar 2020")
      reservation = Hotel::Reservation.new(
        rooms: [Hotel::Room.new(1)], 
        date_range: range)
        expect(reservation.cost).must_equal 400
    end

    it "checks that rooms is an array containing 1 element" do
      range = Hotel::DateRange.new(start_date: "3 Mar 2020", end_date: "5 Mar 2020")
      reservation = Hotel::Reservation.new(
        rooms: [Hotel::Room.new(1)], 
        date_range: range)
        expect(reservation.rooms.first.number).must_equal 1
        expect(reservation.rooms.first).must_be_instance_of Hotel::Room
    end

    it "saves correct dates for check-in and check-out" do
      range = Hotel::DateRange.new(start_date: "3 Mar 2020", end_date: "5 Mar 2020")

      reservation = Hotel::Reservation.new(
        rooms: [Hotel::Room.new(1)], 
        date_range: range)
      expect(reservation.date_range.start_date).must_equal range.start_date
      expect(reservation.date_range.end_date).must_equal range.end_date
    end
  end
end
