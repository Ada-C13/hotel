require_relative "test_helper"

describe Hotel::Reservation do
  describe "constructor" do
    it "is an instance of reservation" do
      expect(Hotel::Reservation.new("2016, 12, 31","2017, 01, 01", 1)).must_be_kind_of Hotel::Reservation
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