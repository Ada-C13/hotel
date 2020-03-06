require_relative "test_helper"

##### In this case we are not writing driver code. That means that your code should deal entirely in Ruby Date objects. Your tests should create Date objects and your library code should assume that it's receiving Date objects to start.

##### When making tests you will want to use something like Date.new(1993, 2, 24) to create a date representing February 24, 1993 (or Date.today for today) instead of trying to parse a string or storing and re-parsing strings internally.

describe Hotel::DateRange do
  describe "constructor" do
    before do
      start_date = Date.new(2017, 01, 01)
      end_date = start_date + 3

      @range = Hotel::DateRange.new(start_date, end_date)
    end

    it "can be initialized with two dates" do
      start_date = Date.new(2017, 01, 01)
      end_date = start_date + 3
      expect(@range.start_date).must_equal start_date
      expect(@range.end_date).must_equal end_date
    end

    it "is set up for specific attributes and data types" do
      expect(@range.start_date).must_be_kind_of Date
      expect(@range.end_date).must_be_kind_of Date
    end

    it "is an an error for negative-length ranges" do
      start_date = Date.new(2017, 02, 01)
      end_date = Date.new(2017, 01, 01) 

      expect{Hotel::DateRange.new(start_date, end_date)}.must_raise ArgumentError
    end

    it "is an error to create a 0-length range" do
      start_date = Date.new(2017, 01, 01)
      end_date = Date.new(2017, 01, 01)
      
      expect{(Hotel::DateRange.new(start_date, end_date))}.must_raise ArgumentError
    end

  end

  describe "overlap?" do
    before do
      start_date = Date.new(2017, 01, 01)
      end_date = start_date + 3

      @range = Hotel::DateRange.new(start_date, end_date)
    end

    it "returns true for the same range" do
      start_date = @range.start_date
      end_date = @range.end_date
      test_range = Hotel::DateRange.new(start_date, end_date)

      expect(@range.overlap?(test_range)).must_equal true
    end

    xit "returns true for a contained range" do
    end

    xit "returns true for a range that overlaps in front" do
    end

    xit "returns true for a range that overlaps in the back" do
    end

    xit "returns true for a containing range" do
    end

    xit "returns false for a range starting on the end_date date" do
    end

    xit "returns false for a range ending on the start_date date" do
    end

    xit "returns false for a range completely before" do
    end

    xit "returns false for a date completely after" do
    end
  end

  xdescribe "include?" do
    it "returns false if the date is clearly out" do
    end

    it "returns true for dates in the range" do
    end

    it "returns false for the end_date date" do
    end
  end

  describe "nights" do
    it "returns the correct number of nights" do
      start_date = Date.new(2017, 01, 01)
      end_date = start_date + 4

      range = Hotel::DateRange.new(start_date, end_date)

      expect(range.nights).must_equal 3
    end
  end
end