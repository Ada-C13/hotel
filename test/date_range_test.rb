require_relative "test_helper"

describe "DateRange" do
  describe "#initialize" do
    it "raise ArgumentError if end date is earlier than start date" do
      start_date = "2020-03-10"
      end_date = "2020-03-08"
      expect{ Hotel::DateRange.new(start_date, end_date) }.must_raise ArgumentError
    end

    it "raise ArgumentError if start date or/and end date is/are invalid" do
      start_date = "2020-01-32"
      end_date = "2020-02-08"
      expect{ Hotel::DateRange.new(start_date, end_date) }.must_raise ArgumentError
    end

    it "Date.parse" do
      @start_date = Date.parse("2020-03-1") 
      @end_date = Date.parse("2020-03-10") 
      expect(@start_date).must_be_kind_of Date
      expect(@end_date).must_be_kind_of Date
    end
  end

  describe "#nights" do
    it "return total nights of the reservation" do
      start_date = "2020-03-08"
      end_date = "2020-03-10"
      date_range = Hotel::DateRange.new(start_date, end_date)

      expect(date_range.nights).must_equal 2
    end
  end

  describe "#dates_except_last" do
    it "list out all the dates of a provided time frame (exclude the last day)" do
      start_date = "2020-03-08"
      end_date = "2020-03-10"
      date_range = Hotel::DateRange.new(start_date, end_date)
  
      expect(date_range.dates_except_last).must_be_kind_of Array
      date_range = Hotel::DateRange.new(start_date, end_date)
      expect(date_range.dates_except_last.length).must_equal 2
    end

    describe "#all_dates" do
      it "list out all the dates of a provided time frame (include the last day)" do
        start_date = "2020-03-08"
        end_date = "2020-03-10"
        date_range = Hotel::DateRange.new(start_date, end_date)
        expect(date_range.all_dates).must_be_kind_of Array
        date_range = Hotel::DateRange.new(start_date, end_date)
        expect(date_range.all_dates.length).must_equal 3
      end
    end

    describe "overlap?" do
    before do
      start_date = "2020-03-05"
      end_date = "2020-03-10"

      @range = Hotel::DateRange.new(start_date, end_date)
    end

    it "returns true for the same range" do
      test_start_date = "2020-03-05"
      test_end_date = "2020-03-10"
      test_range = Hotel::DateRange.new(test_start_date, test_end_date)

      expect(@range.overlap?(test_range)).must_equal true
    end

    it "returns true for a contained range" do
      test_start_date = "2020-03-08"
      test_end_date = "2020-03-09"
      test_range = Hotel::DateRange.new(test_start_date, test_end_date)

      expect(@range.overlap?(test_range)).must_equal true
    end

    it "returns true for a range that overlaps in front" do
      test_start_date = "2020-03-05"
      test_end_date = "2020-03-07"
      test_range = Hotel::DateRange.new(test_start_date, test_end_date)

      expect(@range.overlap?(test_range)).must_equal true
    end

    it "returns true for a range that overlaps in the back" do
      test_start_date = "2020-03-08"
      test_end_date = "2020-03-10"
      test_range = Hotel::DateRange.new(test_start_date, test_end_date)

      expect(@range.overlap?(test_range)).must_equal true
    end

    it "returns true for a containing range" do
      test_start_date = "2020-03-01"
      test_end_date = "2020-03-15"
      test_range = Hotel::DateRange.new(test_start_date, test_end_date)

      expect(@range.overlap?(test_range)).must_equal true
    end

    it "returns false for a range starting on the end_date date" do
      test_start_date = "2020-03-10"
      test_end_date = "2020-03-11"
      test_range = Hotel::DateRange.new(test_start_date, test_end_date)

      expect(@range.overlap?(test_range)).must_equal false
    end

    it "returns false for a range ending on the start_date date" do
      test_start_date = "2020-03-01"
      test_end_date = "2020-03-05"
      test_range = Hotel::DateRange.new(test_start_date, test_end_date)

      expect(@range.overlap?(test_range)).must_equal false
    end

    it "returns false for a range completely before" do
      test_start_date = "2020-03-01"
      test_end_date = "2020-03-02"
      test_range = Hotel::DateRange.new(test_start_date, test_end_date)

      expect(@range.overlap?(test_range)).must_equal false
    end

    it "returns false for a date completely after" do
      test_start_date = "2020-03-15"
      test_end_date = "2020-03-20"
      test_range = Hotel::DateRange.new(test_start_date, test_end_date)

      expect(@range.overlap?(test_range)).must_equal false
    end
  end

  end
end