require_relative 'test_helper'

describe Hotel::DateRange do
  describe "initialize" do
    before do
      @start_date = Date.new(2020, 1, 1)
      @end_date = Date.new(2020, 1, 2)
      @date_range = Hotel::DateRange.new(@start_date, @end_date)
    end

    it "is an instance of DateRange" do
      expect(@date_range).must_be_kind_of Hotel::DateRange
    end

    it "throws an argument error if end_date comes before start_date" do
      error = assert_raises ArgumentError do
        Hotel::DateRange.new(@end_date, @start_date)
      end
      assert_equal(error.message, "Start date must come before end date")
    end

    it "throws an argument error if inputs are not Date objects" do
      start_date = 1
      end_date = Date.today

      error = assert_raises ArgumentError do
        Hotel::DateRange.new(start_date, end_date)
      end
      assert_equal(error.message, "Must be Date objects")
    end
  end

  describe "overlap?" do
    before do
      @start_date = Date.new(2020, 1, 1)
      @end_date = Date.new(2020, 1, 3)
      @date_range_1 = Hotel::DateRange.new(@start_date, @end_date)
      @comparison_range_1 = Hotel::DateRange.new(@start_date+1, @end_date)
    end

    it "returns true if the comparison range start date is inside of current range" do
      puts @date_range_1.start_date
      expect(@date_range_1.overlap?(@comparison_range_1)).must_equal true
    end

    it "returns true if the comparison range end date is inside of current range" do
      comparison_range_2 = Hotel::DateRange.new(@start_date, @end_date-1)
      expect(@date_range_1.overlap?(comparison_range_2)).must_equal true
    end

    it "returns true if the comparison range is inside of the current range" do
      comparison_range_10 = Hotel::DateRange.new(@start_date, @end_date-1)
      expect(@date_range_1.overlap?(comparison_range_10)).must_equal true
    end

    it "returns true if the comparison range encompasses or equals all of the current range" do
      comparison_range_3 = Hotel::DateRange.new(@start_date-1, @end_date+1)
      expect(@date_range_1.overlap?(comparison_range_3)).must_equal true

      comparison_range_4 = Hotel::DateRange.new(@start_date, @end_date)
      expect(@date_range_1.overlap?(comparison_range_4)).must_equal true

      comparison_range_5 = Hotel::DateRange.new(@start_date, @end_date+1)
      expect(@date_range_1.overlap?(comparison_range_5)).must_equal true

      comparison_range_6 = Hotel::DateRange.new(@start_date-1, @end_date)
      expect(@date_range_1.overlap?(comparison_range_6)).must_equal true
    end

    it "returns false if the comparison range does not overlap with the current range" do
      comparison_range_7 = Hotel::DateRange.new(@start_date-4, @end_date-4)
      expect(@date_range_1.overlap?(comparison_range_7)).must_equal false
    
      comparison_range_8 = Hotel::DateRange.new(@start_date+4, @end_date+4)
      expect(@date_range_1.overlap?(comparison_range_8)).must_equal false
    end

    it "returns false if the comparison range starts on the current end date" do
      comparison_range_9 = Hotel::DateRange.new(@end_date, @end_date+1)
      expect(@date_range_1.overlap?(comparison_range_9)).must_equal false
    end
  end
end