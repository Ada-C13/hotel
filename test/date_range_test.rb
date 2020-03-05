require_relative "test_helper"

describe "DateRange" do
  before do
    @date_range = Hotel::DateRange.new(Date.new(2020,5,3), Date.new(2020,5,5))
  end

  describe "initialize" do
    it "creates an instance of DateRange" do
      expect(@date_range).must_be_kind_of Hotel::DateRange
      expect(@date_range).must_respond_to :start_date
      expect(@date_range).must_respond_to :end_date
      expect(@date_range).must_respond_to :range
    end
  end

  describe "total_nights" do
    it "should return correct total of nights for given dates" do
      expect(@date_range.total_nights).must_equal 2
    end
  end

  describe "validate_date" do
    it "should return instance of DateRange if start_date and end_date are Date instances" do
      expect(@date_range).must_be_kind_of Hotel::DateRange
    end

    it "should raise ArgumentError if one or both of start_date and end_date are not Date instances" do
      date1 = Date.new(2020,5,3)
      date2 = "October 24"

      expect{ Hotel::DateRange.new(date1, date2) }.must_raise ArgumentError
    end

    it "should raise ArgumentError if start_date is before today" do
      date1 = Date.new(2020,2,3) 
      date2 = Date.new(2020,5,5)

      expect{ Hotel::DateRange.new(date1, date2) }.must_raise ArgumentError 
    end

    it "should raise ArgumentError if end_date is before start_date" do
      date1 = Date.new(2020,5,3)
      date2 = Date.new(2020,5,1)

      expect{ Hotel::DateRange.new(date1, date2) }.must_raise ArgumentError
    end
  end
  
  describe "overlap?" do
    it "should return true if dates overlap" do
      date_range = Hotel::DateRange.new(Date.new(2020,5,4), Date.new(2020,5,6))
      expect(@date_range.overlap?(date_range)).must_equal true
    end

    it "should return false if dates do not overlap" do
      date_range = Hotel::DateRange.new(Date.new(2020,5,7), Date.new(2020,5,9))
      expect(@date_range.overlap?(date_range)).must_equal false
    end

    it "returns false when check-out day of reservation is same as check-in day of new reservation" do
      date_range = Hotel::DateRange.new(Date.new(2020,5,5), Date.new(2020,5,9))
      expect(@date_range.overlap?(date_range)).must_equal false
    end

    it "returns false when check-in day of reservation is same as check-out day of new reservation" do
      date_range = Hotel::DateRange.new(Date.new(2020,5,1), Date.new(2020,5,3))
      expect(@date_range.overlap?(date_range)).must_equal false
    end
  end
end