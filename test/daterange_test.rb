require_relative 'test_helper'
require 'date'

describe "DateRange" do
  describe "initialize DateRange" do
    it "raises ArgumentError if end date is before start date" do
      expect{Hotel::DateRange.new(start_date: Date.new(2020, 3, 4), end_date: Date.new(2020, 3, 2))}.must_raise ArgumentError
    end

    it "raises ArgumentError if end date and start date are not Date objects" do
      expect{Hotel::DateRange.new(start_date: "March 4, 2020", end_date: "March 2, 2020")}.must_raise ArgumentError
    end

    it "creates a range of the start and end dates" do
      start_date = Date.new(2020, 3, 4)
      end_date = Date.new(2020, 3, 9)
      date_range = Hotel::DateRange.new(start_date: start_date, end_date: end_date)
      expect(date_range.range).must_equal (start_date..end_date).to_a
    end
  end

  describe "overlap?" do
    before do
      @start_date = Date.new(2020, 3, 4)
      @end_date = Date.new(2020, 3, 9)
      @date_range = Hotel::DateRange.new(start_date: @start_date, end_date: @end_date)
    end

    it "returns true if the date is within the range" do
      @date_range2 = Hotel::DateRange.new(start_date: Date.new(2020, 3, 4), end_date: Date.new(2020, 3, 6))
      @date_range3 = Hotel::DateRange.new(start_date: Date.new(2020, 3, 5), end_date: Date.new(2020, 3, 9))
      @date_range4 = Hotel::DateRange.new(start_date: Date.new(2020, 3, 2), end_date: Date.new(2020, 3, 14))
      @date_range5 = Hotel::DateRange.new(start_date: Date.new(2020, 3, 9), end_date: Date.new(2020, 3, 14))
      expect(@date_range.overlap?(@date_range2)).must_equal true
      expect(@date_range.overlap?(@date_range3)).must_equal true
      expect(@date_range.overlap?(@date_range4)).must_equal true
      expect(@date_range.overlap?(@date_range5)).must_equal true
    end

    it "returns false if the date is not within the range" do
      @date_range2 = Hotel::DateRange.new(start_date: Date.new(2020, 3, 10), end_date: Date.new(2020, 3, 15))
      @date_range3 = Hotel::DateRange.new(start_date: Date.new(2020, 3, 11), end_date: Date.new(2020, 3, 13))
      @date_range4 = Hotel::DateRange.new(start_date: Date.new(2020, 3, 2), end_date: Date.new(2020, 3, 3))
      @date_range5 = Hotel::DateRange.new(start_date: Date.new(2020, 2, 9), end_date: Date.new(2020, 2, 16))
      expect(@date_range.overlap?(@date_range2)).must_equal false
      expect(@date_range.overlap?(@date_range3)).must_equal false
      expect(@date_range.overlap?(@date_range4)).must_equal false
      expect(@date_range.overlap?(@date_range5)).must_equal false
    end

  end
  
end