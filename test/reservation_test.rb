require_relative "test_helper"

describe Hotel::Reservation do
  describe "constructor" do
    before do
      @reservation = Hotel::Reservation.new(Date.new(2017, 01, 05),Date.new(2017, 01, 06))
    end

    it "is an instance of reservation" do
      expect(@reservation).must_be_kind_of Hotel::Reservation
    end

    it "is set up for specific attributes and data types" do
      expect(@reservation.start_date).must_be_kind_of Date
      expect(@reservation.end_date).must_be_kind_of Date
    end
  end

  describe "cost" do
    before do 
      start_date = Date.new(2017, 01, 01)
      end_date = start_date + 3
      @reservation = Hotel::Reservation.new(start_date, end_date)
    end

    it "returns a number" do
      expect(@reservation.cost).must_be_kind_of Numeric
    end

    it "returns the correct cost" do
      expect(@reservation.cost).must_equal 400
    end
  end
end