require_relative "test_helper"

describe Hotel::Reservation do
  before do
    @reservation = Hotel::Reservation.new(
      start_date: Date.new(2021, 01, 01),
      end_date: Date.new(2021, 01, 04),
      room: 2,
      cost: 200
    )
  end

  describe "initialize" do
    it "is an instance of Reservation" do
      expect(@reservation).must_be_kind_of Hotel::Reservation
    end

    it "raises an error if the end date is the same as the start date" do
      expect { Hotel::DateRange.new(Date.new(2021, 01, 01),Date.new(2021, 01, 01)) }.must_raise ArgumentError
    end
  end

  describe "cost" do
    it "returns a number" do
      expect(@reservation.cost).must_be_kind_of Numeric
    end
  end

  describe "total_cost method" do
    it "returns a number" do
      expect(@reservation.total_cost).must_be_kind_of Numeric
    end
  end
end
