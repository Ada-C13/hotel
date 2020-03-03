require_relative "test_helper"

describe Hotel::Reservation do
  before do
    @reservation = Hotel::Reservation.new(start_date = Date.new(2021, 01, 01), end_date = start_date + 3, room = 2, cost = 200)
  end

  describe "initialize" do
    it "is an instance of Reservation" do
      expect(@reservation).must_be_kind_of Hotel::Reservation
    end
  end

  describe "cost" do
    it "returns a number" do
      start_date = Date.new(2017, 01, 01)
      end_date = start_date + 3
      reservation = Hotel::Reservation.new(start_date, end_date, nil)
      expect(reservation.cost).must_be_kind_of Numeric
    end
  end
end
