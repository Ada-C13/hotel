require_relative 'test_helper'

describe "DateRange Class" do
  before do
    start_date = Date.today + 5
    end_date = Date.today + 10
    @range01 = Hotel::DateRange.new(start_date, end_date)
  end

  describe "Initialize" do
    it "is an instance of DateRange" do
      expect(@range01).must_be_kind_of Hotel::DateRange
    end

    it "stores a start date that is a Date class" do
      expect(@range01.start_date).must_be_kind_of Date
    end

    it "stores an end date that is a Date class" do
      expect(@range01.end_date).must_be_kind_of Date
    end

    it "raises an ArgumentError if end date is before start date" do
      start_date = Date.today + 5
      end_date = Date.today + 1
      expect{Hotel::DateRange.new(start_date, end_date)}.must_raise ArgumentError
    end

    it "raises ArgumentError if start_date or end_date is not a Date class" do
      start_date = Date.today + 10
      end_date = Date.today + 15
      expect{Hotel::DateRange.new("2025/03/25", end_date)}.must_raise ArgumentError
      expect{Hotel::DateRange.new(start_date, 20250327)}.must_raise ArgumentError
    end

    it "raises ArgumentError if start_date is in the past" do
      start_date = Date.today - 5
      end_date = Date.today + 1
      expect{Hotel::DateRange.new(start_date, end_date)}.must_raise ArgumentError
    end

    it "raises ArgumentError for a 0-length date range" do
      start_date = Date.today
      end_date = start_date
      expect{Hotel::DateRange.new(start_date, end_date)}.must_raise ArgumentError
    end

  end

  describe "#count_nights" do
    it "counts the total nights of stay within a date range" do
      expect(@range01.count_nights).must_equal 5
      expect(@range01.count_nights).must_be_instance_of Integer
    end
  end

  describe "#including" do
    it "returns true if the other date range is included in the date range" do
      range21 = Hotel::DateRange.new(Date.today + 7, Date.today + 8)
      expect(@range01.including(range21)).must_equal true
      range23 = Hotel::DateRange.new(Date.today + 5, Date.today + 6)
      expect(@range01.including(range23)).must_equal true
    end

    it "returns false if the other date range is not included in the date range" do
      range22 = Hotel::DateRange.new(Date.today + 1, Date.today + 2)
      expect(@range01.including(range22)).must_equal false
      range24 = Hotel::DateRange.new(Date.today + 8, Date.today + 20)
      expect(@range01.including(range24)).must_equal false
      range26 = Hotel::DateRange.new(Date.today + 10, Date.today + 11)  #edge case for checkout date
      expect(@range01.including(range26)).must_equal false
      range28 = Hotel::DateRange.new(Date.today + 4, Date.today + 5) #edge case for checkout date
      expect(@range01.including(range28)).must_equal false
    end
  end

  describe "#include_date" do
    it "returns true if the specific date is included in the date range" do
      date01 = Date.today + 8
      date03 = Date.today + 5
      expect(@range01.include_date(date01)).must_equal true
      expect(@range01.include_date(date03)).must_equal true
    end

    it "returns false if the specific date is not included in the date range" do
      date02 = Date.today + 1
      date04 = Date.today + 20
      date06 = Date.today + 10
      expect(@range01.include_date(date02)).must_equal false
      expect(@range01.include_date(date04)).must_equal false
      expect(@range01.include_date(date06)).must_equal false
    end
  end

  describe "#overlapping" do
    it "returns true if the two date ranges overlap" do
      range03 = Hotel::DateRange.new(Date.today + 6, Date.today + 8)
      expect(@range01.overlapping(range03)).must_equal true
      range04 = Hotel::DateRange.new(Date.today + 5, Date.today + 6)
      expect(@range01.overlapping(range04)).must_equal true
      range05 = Hotel::DateRange.new(Date.today+8, Date.today+20)
      expect(@range01.overlapping(range05)).must_equal true
    end

    it "returns false if the two date ranges do not overlap" do
      range06 = Hotel::DateRange.new(Date.today + 1, Date.today + 3)
      expect(@range01.overlapping(range06)).must_equal false
      range09 = Hotel::DateRange.new(Date.today + 100, Date.today + 103)
      expect(@range01.overlapping(range09)).must_equal false
    end

    it "returns false if it is only the start date overlapping end date" do
      range07 = Hotel::DateRange.new(Date.today + 10, Date.today + 12) #edge case for checkout date
      expect(@range01.overlapping(range07)).must_equal false
      range08 = Hotel::DateRange.new(Date.today + 1, Date.today + 5) #edge case for checkout date
      expect(@range01.overlapping(range08)).must_equal false
    end
  end
end
