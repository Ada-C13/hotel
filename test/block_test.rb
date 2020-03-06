require_relative 'test_helper'

describe "HotelBlock class" do
  describe "#initialize" do
    it "creates an instance of a HotelBlock class" do
      range = Hotel::DateRange.new(start_date: "2 Mar 2020", end_date: "5 Mar 2020")
      booking = Hotel::HotelBlock.new(
        rooms: [Hotel::Room.new(1), Hotel::Room.new(2)],
        date_range: range,
        discounted_rate: 150)
      expect(booking).must_be_instance_of Hotel::HotelBlock
    end

    it "calculates the cost of reservation, does not count the last day" do
      range = Hotel::DateRange.new(start_date: "3 Mar 2020", end_date: "5 Mar 2020")
      booking = Hotel::HotelBlock.new(
        rooms: [Hotel::Room.new(1), Hotel::Room.new(2)],
        date_range: range,
        discounted_rate: 150)
      expect(booking.cost).must_equal 600
    end
  end
end
