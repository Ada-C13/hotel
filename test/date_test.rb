require_relative "test_helper"

describe "DateRange" do

  describe "contains" do
    before do
      @reservation = Hotel::Reservation.new(start_date: Date.new(2020, 5, 1), end_date: Date.new(2020, 5, 4), num_rooms: 1)
    end

    it "returns true if requested date is contained in reservation dates" do
      expect(@reservation.contains(Date.new(2020, 5, 2))).must_equal true
    end

    it "returns true if requested date is first day in reservation dates" do
      expect(@reservation.contains(Date.new(2020, 5, 1))).must_equal true
    end

    it "returns false if requested date is last day in reservation dates" do
      expect(@reservation.contains(Date.new(2020, 5, 4))).must_equal false
    end
  end

  describe "conflict?" do
    before do
      @reservation = Hotel::Reservation.new(start_date: Date.new(2020, 5, 1), end_date: Date.new(2020, 5, 4), num_rooms: 1)
    end

    it "returns true if requested dates are contained in current reservation dates" do
      expect(@reservation.no_conflict?(Date.new(2020, 5, 2), Date.new(2020, 5, 4))).must_equal false
    end

    it "returns true if requested start date is the same as current end date" do
      expect(@reservation.no_conflict?(Date.new(2020, 5, 4), Date.new(2020, 5, 5))).must_equal true
    end

    it "returns false if requested start date is earlier than current end date" do
      expect(@reservation.no_conflict?(Date.new(2020, 5, 2), Date.new(2020, 5, 5))).must_equal false
    end
  end
end