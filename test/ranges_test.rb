require_relative 'test_helper'

describe "Date Range" do
  before do
    @range = Hotel::DateRange.new(start_date: "3 Mar", end_date: "5 Mar")
    @range2 = Hotel::DateRange.new(start_date: "4 Mar", end_date: "6 Mar")
  end

  describe "#initialize" do
    it "creates an instance of DateRange class" do
      expect(@range).must_be_instance_of Hotel::DateRange
    end

    it "raises an Argument Error if the end date is less than or equal to start date" do
      expect{Hotel::DateRange.new(start_date: "7 Mar 2020", end_date: "5 Mar 2020")}.must_raise ArgumentError
    end
  end

  describe "#overlap?" do
    it "checks 2 ranges for overlapping" do
      expect(@range.overlap?(@range2)).must_equal true
    end

    it "returns false if check-in date is the same as another check-out date" do
      range2 = Hotel::DateRange.new(start_date: "5 Mar", end_date: "7 Mar")
      expect(@range.overlap?(range2)).must_equal false
    end

    it "returns false if there is no overlapping" do
      range2 = Hotel::DateRange.new(start_date: "6 Mar", end_date: "8 Mar")
      expect(@range.overlap?(range2)).must_equal false
    end
  end

  describe "#days" do
    it "calculates days of a date range" do
      expect(@range.days).must_equal 2
    end
  end
end
