require_relative "test_helper"

describe "DateRange class" do
  let (:date_range) {

    # Arrange
    start_date = Date.today
    end_date = start_date + 7

    # Act
    Hotel::DateRange.new(start_date, end_date)
  }

  describe "#initialize" do
    it "creates start_date and end_date" do
      # Assert
      expect(date_range).must_respond_to :start_date
      expect(date_range).must_respond_to :end_date

      expect(date_range.start_date).must_be_instance_of Date
      expect(date_range.end_date).must_be_instance_of Date

      expect(date_range.start_date).must_equal date_range.start_date
      expect(date_range.end_date).must_equal date_range.end_date
    end

    it "raises a DateRangeError if start date is after end date" do
      expect { Hotel::DateRange.new(Date.today, Date.today - 5) }.must_raise Hotel::DateRangeError
    end

    it "raise a DateRangeError to create a 0-length range" do
      expect {
        Hotel::DateRange.new(Date.today, Date.today)
      }.must_raise Hotel::DateRangeError
    end


    it "raises a DateRangeError when the date range is not between current date and end of the year" do

      # Act & Assert
      expect {
        Hotel::DateRange.new(Date.today - 10, Date.today - 5)
      }.must_raise Hotel::DateRangeError

      expect {
        Hotel::DateRange.new(Date.today - 400, Date.today + 7)
      }.must_raise Hotel::DateRangeError
    end
  end

  describe "#nights" do
    it "calculates the correct number of nights" do
      expect(date_range).must_respond_to :nights

      expect(date_range.nights).must_be_kind_of Integer

      expect(date_range.nights).must_equal 7
    end
  end

  describe "#include?" do
    it "returns true for dates in the range" do
      date_1 = Date.today
      date_2 = Date.today + 5
      date_3 = Date.today + 6

      expect(date_range.include?(date_1)).must_equal true
      expect(date_range.include?(date_2)).must_equal true
      expect(date_range.include?(date_3)).must_equal true
    end

    it "returns ture for the start_date" do
      date = Date.today

      expect(date_range.include?(date)).must_equal true
    end

    it "returns false if the date is clearly out" do
      date = Date.today + 90

      expect(date_range.include?(date)).must_equal false
    end

    it "returns false for the end_date" do
      date = Date.today + 7

      expect(date_range.include?(date)).must_equal false
    end
  end


  describe "#overlap?" do
    before do
      start_date = Date.today
      end_date = start_date + 7

      @range = Hotel::DateRange.new(start_date, end_date)
    end

    it "returns true for the same range" do
      start_date = Date.today
      end_date = start_date + 7

      test_range = Hotel::DateRange.new(start_date, end_date)

      expect(@range.overlap?(test_range)).must_equal true
    end

    it "returns true for a contained range" do
      range = Hotel::DateRange.new(Date.today + 60, Date.today + 67)
      test_range = Hotel::DateRange.new(Date.today + 62, Date.today + 64)

      expect(range.overlap?(test_range)).must_equal true
    end

    it "returns true for a range that overlaps in front" do
      range = Hotel::DateRange.new(Date.today + 60, Date.today + 67)
      test_range = Hotel::DateRange.new(Date.today + 57, Date.today + 63)

      expect(range.overlap?(test_range)).must_equal true
    end

    it "returns true for a range that overlaps in the back" do
      range = Hotel::DateRange.new(Date.today + 60, Date.today + 67)
      test_range = Hotel::DateRange.new(Date.today + 66, Date.today + 72)

      expect(range.overlap?(test_range)).must_equal true
    end

    it "returns true for a containing range" do
      range = Hotel::DateRange.new(Date.today + 60, Date.today + 67)
      test_range = Hotel::DateRange.new(Date.today + 57, Date.today + 68)

      expect(range.overlap?(test_range)).must_equal true
    end

    it "returns false for a range starting on the end_date" do
      range = Hotel::DateRange.new(Date.today + 60, Date.today + 67)
      test_range = Hotel::DateRange.new(Date.today + 67, Date.today + 70)

      expect(range.overlap?(test_range)).must_equal false
    end

    it "returns false for a range ending on the start_date" do
      range = Hotel::DateRange.new(Date.today + 60, Date.today + 67)
      test_range = Hotel::DateRange.new(Date.today + 54, Date.today + 60)

      expect(range.overlap?(test_range)).must_equal false
    end

    it "returns false for a range completely before" do
      range = Hotel::DateRange.new(Date.today + 60, Date.today + 67)
      test_range = Hotel::DateRange.new(Date.today + 54, Date.today + 55)

      expect(range.overlap?(test_range)).must_equal false
    end

    it "returns false for a date completely after" do
      range = Hotel::DateRange.new(Date.today + 60, Date.today + 67)
      test_range = Hotel::DateRange.new(Date.today + 80, Date.today + 85)

      expect(range.overlap?(test_range)).must_equal false
    end
  end
end
