require_relative "test_helper"

describe Hotel::Reservation do
  describe "constructor" do
    before do
      @reservation = Hotel::Reservation.new("20010203","20010206", 1)
    end
    it "is an instance of reservation" do
      expect(@reservation).must_be_kind_of Hotel::Reservation
    end

    it "raises an argument error for negative-length ranges" do
      start_date = Date.new(2017, 01, 06)
      end_date = Date.new(2017, 01, 05)
      expect{Hotel::Reservation.new(start_date, end_date, 1)}.must_raise ArgumentError
    end

    it "raises an error when there is a 0-length range" do
      start_date = Date.new(2017, 01, 01)
      end_date = Date.new(2017, 01, 01)
      
      expect{Hotel::Reservation.new(start_date, end_date, 1)}.must_raise ArgumentError
    end
  end

  describe "cost" do
    before do 
      start_date = Date.new(2017, 01, 01)
      end_date = start_date + 3
      @reservation = Hotel::Reservation.new(start_date, end_date, nil)
    end

    it "returns a number" do
      expect(@reservation.cost).must_be_kind_of Numeric
    end

    it "returns the correct cost" do
      expect(@reservation.cost).must_equal 400
    end
  end

 
end