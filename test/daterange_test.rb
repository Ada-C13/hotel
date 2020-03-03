require_relative 'test_helper'

describe "DateRange Class" do
  before do
    start_date = Date.today + 5
    end_date = Date.today + 10
  
    @range01 = Hotel::DateRange.new(start_date, end_date)
  end

  describe "Initialize" do
    
    it "Is an instance of DateRange" do
      expect(@range01).must_be_kind_of Hotel::DateRange
    end

    it "Stores a start date that is a Date class" do
      expect(@range01.start_date).must_be_kind_of Date
    end

    it "Stores an end date that is a Date class" do
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
      expect{Hotel::DateRange.new("2020/03/25", end_date)}.must_raise ArgumentError
      expect{Hotel::DateRange.new(start_date, 20200327)}.must_raise ArgumentError
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

  describe "#include" do
    it "returns true if the date is included in the date range" do
      day01 = Date.today + 7
      expect(@range01.include(day01)).must_equal true
    end

    it "returns false if the date is not included in the date range" do
      day02 = Date.today + 1
      expect(@range01.include(day02)).must_equal false
    end
  end

  describe "#overlap" do
    it "returns true if the two date ranges overlap" do
      start_date = Date.today + 6
      end_date = Date.today + 8
      range03 = Hotel::DateRange.new(start_date, end_date)
      expect(@range01.overlap(range03)).must_equal true
    end

    it "returns false if it is only the start date overlaps end date" do
      start_date = Date.today + 10
      end_date = Date.today + 12
      range04 = Hotel::DateRange.new(start_date, end_date)
      expect(@range01.overlap(range04)).must_equal false
    end
  end
end



