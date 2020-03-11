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

      expect {Hotel::DateRange.new(start_date, end_date)}.must_raise ArgumentError
    end

    it "is an error to create a 0-length range" do
      start_date = 0
      end_date = 0
      expect {Hotel::DateRange.new(start_date, end_date)}.must_raise ArgumentError
    end
  end

  describe "overlap?" do
    before do
      start_date = Date.new(2017, 01, 01)
      end_date = start_date + 3

      @range = Hotel::DateRange.new(start_date, end_date)
    end

    it "returns false" do
      start_date = @range.end_date
      end_date = @range.end_date
      test_range = Hotel::DateRange.new(start_date, end_date)

      expect(@range.overlap?(test_range)).must_equal false
    end

    it "returns true for the same range" do
      start_date = @range.start_date
      end_date = @range.end_date
      test_range = Hotel::DateRange.new(start_date, end_date)

      expect(@range.overlap?(test_range)).must_equal true
    end
  end
end