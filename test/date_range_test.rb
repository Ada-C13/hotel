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

    it "is an an error for negative-lenght ranges" do
      start_date = Date.new(2017, 01, 01)
      end_date = start_date - 3

      expect{Hotel::DateRange.new(start_date, end_date)}.must_raise ArgumentError
    end

    it "is an error to create a 0-length range" do
      start_date = Date.new(2017, 01, 01)
      end_date = start_date

      expect{Hotel::DateRange.new(start_date, end_date)}.must_raise ArgumentError
    end
    it "makes dates a date class" do
      start_date = ("2020-08-04")
      end_date = ("2020-08-09")

      range = Hotel::DateRange.new(start_date, end_date)

      expect(range.start_date).must_be_instance_of Date
      expect(range.end_date).must_be_instance_of Date
    end
  end

  describe "overlap?" do
    before do
      start_date = Date.parse("2020-08-04")
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
      start_date = @range.start_date #"2020-08-04"
      end_date = @range.end_date - 1
      test_range = Hotel::DateRange.new(start_date, end_date)

      expect(@range.overlap?(test_range)).must_equal true
    end

    it "returns true for a range that overlaps in front" do
      start_date = @range.start_date - 1 #"2020-08-04"
      end_date = @range.end_date - 1
      test_range = Hotel::DateRange.new(start_date, end_date)

      expect(@range.overlap?(test_range)).must_equal true
    end

    it "returns true for a range that overlaps in the back" do
      start_date = @range.start_date + 2 #"2020-08-04"
      end_date = @range.end_date + 2
      test_range = Hotel::DateRange.new(start_date, end_date)

      expect(@range.overlap?(test_range)).must_equal true
    end

    it "returns true for a containing range" do
      start_date = @range.start_date - 2 #"2020-08-04"
      end_date = @range.end_date + 2
      test_range = Hotel::DateRange.new(start_date, end_date)

      expect(@range.overlap?(test_range)).must_equal true
    end

    it "returns false for a range starting on the end_date date" do
      start_date = @range.end_date #"2020-08-04"
      end_date = @range.end_date + 3
      test_range = Hotel::DateRange.new(start_date, end_date)

      expect(@range.overlap?(test_range)).must_equal false
    end

    it "returns false for a range ending on the start_date date" do
      start_date = @range.start_date - 4 #"2020-08-04"
      end_date = @range.start_date
      test_range = Hotel::DateRange.new(start_date, end_date)

      expect(@range.overlap?(test_range)).must_equal false
    end

    it "returns false for a range completely before" do
      start_date = @range.start_date - 10 #"2020-08-04"
      end_date = @range.end_date - 10
      test_range = Hotel::DateRange.new(start_date, end_date)

      expect(@range.overlap?(test_range)).must_equal false
    end

    it "returns false for a date completely after" do
      start_date = @range.start_date + 10 #"2020-08-04"
      end_date = @range.end_date + 10
      test_range = Hotel::DateRange.new(start_date, end_date)

      expect(@range.overlap?(test_range)).must_equal false
    end
  end

  xdescribe "include?" do
    it "reuturns false if the date is clearly out" do
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

      expect(DateRange.new(start_date, end_date).nights).must_equal 3
    end
  end
end