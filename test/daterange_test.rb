require_relative 'test_helper'

describe "DateRange" do
  describe "initialize DateRange" do
    it "raises ArgumentError if end date is before start date" do
      expect{Hotel::DateRange.new(start_date: Date.today + 6, end_date: Date.today + 2)}.must_raise ArgumentError
    end

    it "raises ArgumentError if end date and start date are not Date objects" do
      expect{Hotel::DateRange.new(start_date: "March 4, 2020", end_date: "March 2, 2020")}.must_raise ArgumentError
    end

    it "creates a range of the start and end dates" do
      start_date = Date.today + 2
      end_date = Date.today + 6
      date_range = Hotel::DateRange.new(start_date: start_date, end_date: end_date)
      expect(date_range.range).must_equal (start_date..end_date).to_a
    end
  end

  describe "overlap?" do
    before do
      @start_date = Date.today + 2
      @end_date = Date.today + 6
      @date_range = Hotel::DateRange.new(start_date: @start_date, end_date: @end_date)
    end

    it "returns true if there is overlap between date ranges" do
      date_range2 = Hotel::DateRange.new(start_date: Date.today + 2, end_date: Date.today + 4)
      date_range3 = Hotel::DateRange.new(start_date: Date.today + 3, end_date: Date.today + 6)
      date_range4 = Hotel::DateRange.new(start_date: Date.today + 1, end_date: Date.today + 9)
      date_range5 = Hotel::DateRange.new(start_date: Date.today + 1, end_date: Date.today + 6)
      expect(@date_range.overlap?(date_range2)).must_equal true
      expect(@date_range.overlap?(date_range3)).must_equal true
      expect(@date_range.overlap?(date_range4)).must_equal true
      expect(@date_range.overlap?(date_range5)).must_equal true
    end

    it "returns false if the date is not within the range" do
      date_range2 = Hotel::DateRange.new(start_date: Date.today + 6, end_date: Date.today + 9)
      date_range3 = Hotel::DateRange.new(start_date: Date.today + 7, end_date: Date.today + 13)
      date_range4 = Hotel::DateRange.new(start_date: Date.today + 1, end_date: Date.today + 2)
      date_range5 = Hotel::DateRange.new(start_date: Date.today + 19, end_date: Date.today + 20)
      date_range5 = Hotel::DateRange.new(start_date: Date.today , end_date: Date.today + 1)
      expect(@date_range.overlap?(date_range2)).must_equal false
      expect(@date_range.overlap?(date_range3)).must_equal false
      expect(@date_range.overlap?(date_range4)).must_equal false
      expect(@date_range.overlap?(date_range5)).must_equal false
    end

  end

  describe "nights" do
    
    start_date = Date.today + 2
    end_date = Date.today + 6
    date_range = Hotel::DateRange.new(start_date:start_date, end_date:end_date)
   
    it "calculates the number of nights booked" do
      expect(date_range.nights).must_equal 4
    end
  end
  
end