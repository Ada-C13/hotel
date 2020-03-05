require_relative "test_helper"

describe Hotel::Reservation do
  before do
    test_range = Array(Date.new(2021, 01, 01) .. Date.new(2021, 01, 04))

    @reservation = Hotel::Reservation.new(
      date_range: test_range,
      room: 2
    )
  end

  describe "initialize" do
    it "is an instance of Reservation" do
      expect(@reservation).must_be_kind_of Hotel::Reservation
    end
  end

  # ! TODO this is broken
  xdescribe "cost" do
    it "returns a number" do
      expect(cost(@reservation)).must_be_kind_of Numeric
    end
  end
end
