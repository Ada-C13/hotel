require_relative "test_helper"

describe Hotel::DateRange do
  describe "consructor" do
    it "Can be initialized with two dates" do
      start_date = Date.new(2017, 01, 01)
      end_date = start_date + 3

      range = Hotel::DateRange.new(start_date, end_date)

      expect(range.start_date).must_equal start_date
      expect(range.end_date).must_equal end_date
    end

    it "is an an error for negative-length ranges" do
      start_date = Date.new(2020,03,03)
      end_date = start_date - 3
      expect{Hotel::DateRange.new(start_date, end_date)}.must_raise ArgumentError

    end

    it "is an error to create a 0-length range" do
      start_date = Date.new(2020,03,05)
      end_date = start_date
      expect{Hotel::DateRange.new(start_date,end_date)}.must_raise ArgumentError
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

    it "returns true for a contained range" do
      contained_start_date = @range.start_date + 1
      contained_end_date = @range.start_date + 2
      
      new_test_range = Hotel::DateRange.new(contained_start_date, contained_end_date)
      expect(@range.overlap?(new_test_range)).must_equal true

    end

    it "returns true for a range that overlaps in front" do
      second_start_date = Date.new(2016, 12, 29)
      second_end_date = second_start_date + 4
      second_range = Hotel::DateRange.new(second_start_date, second_end_date)

      expect(@range.overlap?(second_range)).must_equal true
    end

    it "returns true for a range that overlaps in the back" do
      second_start_date = Date.new(2017, 01, 03)
      second_end_date = second_start_date + 4
      second_range = Hotel::DateRange.new(second_start_date, second_end_date)

      expect(@range.overlap?(second_range)).must_equal true
    end

    it "returns true for a containing range" do
      second_start_date = Date.new(2017, 01, 02)
      second_end_date = second_start_date + 1
      second_range = Hotel::DateRange.new(second_start_date, second_end_date)

      expect(@range.overlap?(second_range)).must_equal true
    end

    it "returns false for a range starting on the end_date date" do
      second_start_date = Date.new(2017, 01, 04)
      second_end_date = second_start_date + 2
      second_range = Hotel::DateRange.new(second_start_date, second_end_date)

      expect(@range.overlap?(second_range)).must_equal false
    end

    it "returns false for a range ending on the start_date date" do
      second_start_date = Date.new(2016, 12, 30)
      second_end_date = second_start_date + 2
      second_range = Hotel::DateRange.new(second_start_date, second_end_date)

      expect(@range.overlap?(second_range)).must_equal false
    end

    it "returns false for a range completely before" do
      second_start_date = Date.new(2016, 10, 30)
      second_end_date = second_start_date + 2
      second_range = Hotel::DateRange.new(second_start_date, second_end_date)

      expect(@range.overlap?(second_range)).must_equal false
    end

    it "returns false for a date completely after" do
      second_start_date = Date.new(2017, 12, 30)
      second_end_date = second_start_date + 2
      second_range = Hotel::DateRange.new(second_start_date, second_end_date)

      expect(@range.overlap?(second_range)).must_equal false
    end
  end

  describe "include?" do

    before do
      start_date = Date.new(2020, 03, 15)
      end_date = start_date + 5

      @range = Hotel::DateRange.new(start_date, end_date)
    end

    it "reutrns false if the date is clearly out" do

      expect(@range.include?(Date.new(2020, 03, 30))).must_equal false

    end

    it "returns true for dates in the range" do

      expect(@range.include?(Date.new(2020, 03, 17))).must_equal true

    end

    it "returns false for the end_date date" do

      expect(@range.include?(Date.new(2020, 03, 20))).must_equal false

    end
  end

  describe "nights" do
    it "returns the correct number of nights" do
      start_date = Date.new(2020, 03, 17)
      end_date = start_date + 4

      expect(Hotel::DateRange.new(start_date, end_date).nights).must_equal 4
    end

    it "returns the correct number of nights for dates within 2 different months" do
      start_date = Date.new(2020, 03, 17)
      end_date = start_date + 25

      expect(Hotel::DateRange.new(start_date, end_date).nights).must_equal 25
    end

  end
end