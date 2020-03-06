require_relative "test_helper"

##### In this case we are not writing driver code. That means that your code should deal entirely in Ruby Date objects. Your tests should create Date objects and your library code should assume that it's receiving Date objects to start.

##### When making tests you will want to use something like Date.new(1993, 2, 24) to create a date representing February 24, 1993 (or Date.today for today) instead of trying to parse a string or storing and re-parsing strings internally.

describe Hotel::Reservation do
  describe "constructor" do
    before do
      @reservation = Hotel::Reservation.new(Date.new(2017, 01, 05),Date.new(2017, 01, 06))
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