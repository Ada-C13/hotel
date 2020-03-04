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
      start_date = Date.new(2017, 01, 01)
      end_date = start_date - 3
      expect{Hotel::DateRange.new(start_date, end_date)}.must_raise Hotel::InvalidDateRangeError
    end

    it "is an error to create a 0-length range" do
      start_date = Date.new(2017, 01, 01)
      end_date = start_date
      expect{Hotel::DateRange.new(start_date, end_date)}.must_raise Hotel::InvalidDateRangeError
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
      cont_start = Date.new(2017, 01, 02)
      cont_end = Date.new(2017, 01, 03)
      contained_range = Hotel::DateRange.new(cont_start, cont_end)
      expect(@range.overlap?(contained_range)).must_equal true
    end

    it "returns true for a range that overlaps in front" do
      cont_start = Date.new(2016, 12, 31)
      cont_end = Date.new(2017, 01, 02)
      contained_range = Hotel::DateRange.new(cont_start, cont_end)
      expect(@range.overlap?(contained_range)).must_equal true
    end

    it "returns true for a range that overlaps in the back" do
      cont_start = Date.new(2017, 01, 03)
      cont_end = Date.new(2017, 01, 07)
      contained_range = Hotel::DateRange.new(cont_start, cont_end)
      expect(@range.overlap?(contained_range)).must_equal true
    end

    it "returns true for a containing range" do
      cont_start = Date.new(2016, 12, 30)
      cont_end = Date.new(2017, 01, 07)
      contained_range = Hotel::DateRange.new(cont_start, cont_end)
      expect(@range.overlap?(contained_range)).must_equal true
    end

    it "returns false for a range starting on the end_date date" do
      cont_start = Date.new(2017, 01, 04)
      cont_end = Date.new(2017, 01, 07)
      contained_range = Hotel::DateRange.new(cont_start, cont_end)
      expect(@range.overlap?(contained_range)).must_equal false
    end

    it "returns false for a range ending on the start_date date" do
      cont_start = Date.new(2016, 12, 29)
      cont_end = Date.new(2017, 01, 01)
      contained_range = Hotel::DateRange.new(cont_start, cont_end)
      expect(@range.overlap?(contained_range)).must_equal false
    end

    it "returns false for a range completely before" do
      cont_start = Date.new(2016, 12, 25)
      cont_end = Date.new(2016, 12, 31)
      contained_range = Hotel::DateRange.new(cont_start, cont_end)
      expect(@range.overlap?(contained_range)).must_equal false
    end

    it "returns false for a date completely after" do
      cont_start = Date.new(2017, 12, 25)
      cont_end = Date.new(2017, 12, 31)
      contained_range = Hotel::DateRange.new(cont_start, cont_end)
      expect(@range.overlap?(contained_range)).must_equal false
    end
  end

  describe "include?" do
    before do
      start_date = Date.new(2017, 01, 01)
      end_date = start_date + 3
      @range = Hotel::DateRange.new(start_date, end_date)
    end
    it "reutrns false if the date is clearly out" do
      target = Date.new(2016, 01, 01)
      expect(@range.include?(target)).must_equal false
    end

    it "returns true for dates in the range" do
      target = Date.new(2017, 01, 01)
      expect(@range.include?(target)).must_equal true
    end

    it "returns false for the end_date date" do
      target = Date.new(2016, 01, 04)
      expect(@range.include?(target)).must_equal false
    end
  end

  describe "nights" do
    it "returns the correct number of nights" do
      cont_start = Date.new(2016, 12, 25)
      cont_end = Date.new(2016, 12, 31)
      range = Hotel::DateRange.new(cont_start, cont_end)
      expect(range.num_nights).must_equal 6

      cont_start = Date.new(2016, 12, 29)
      cont_end = Date.new(2017, 01, 01)
      range = Hotel::DateRange.new(cont_start, cont_end)
      expect(range.num_nights).must_equal 3

      cont_start = Date.new(2017, 01, 04)
      cont_end = Date.new(2017, 01, 07)
      range = Hotel::DateRange.new(cont_start, cont_end)
      expect(range.num_nights).must_equal 3

      cont_start = Date.new(2016, 12, 30)
      cont_end = Date.new(2017, 01, 07)
      range = Hotel::DateRange.new(cont_start, cont_end)
      expect(range.num_nights).must_equal 8

      cont_start = Date.new(2016, 12, 31)
      cont_end = Date.new(2017, 01, 02)
      range = Hotel::DateRange.new(cont_start, cont_end)
      expect(range.num_nights).must_equal 2

      cont_start = Date.new(2017, 01, 02)
      cont_end = Date.new(2017, 01, 03)
      range = Hotel::DateRange.new(cont_start, cont_end)
      expect(range.num_nights).must_equal 1

      cont_start = Date.new(2017, 01, 01)
      cont_end = Date.new(2017, 02, 01)
      range = Hotel::DateRange.new(cont_start, cont_end)
      expect(range.num_nights).must_equal 31

    end
  end
end
