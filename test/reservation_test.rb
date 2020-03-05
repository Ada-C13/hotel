require_relative "test_helper"

describe Hotel::Reservation do
  before do
    @reservation = Hotel::Reservation.new(
      start_date: Date.new(2021, 01, 01),
      end_date: Date.new(2021, 01, 04),
      room: 2
    )
  end

  describe "initialize" do
    it "is an instance of Reservation" do
      expect(@reservation).must_be_kind_of Hotel::Reservation
    end
  end

  describe "total_cost method" do
    it "returns a number" do
      expect(@reservation.cost).must_be_kind_of Numeric
    end
  end
end
