require_relative "test_helper"

describe "DateRange" do
  before do
    @daterange = Hotel::DateRange.new(Date.new(2020,5,3), Date.new(2020,5,5))
  end

  describe "initialize" do
    it "creates an instance of DateRange" do
      expect(@daterange).must_be_kind_of Hotel::DateRange
      expect(@daterange).must_respond_to :start_date
    end

    it "start_date must be instance of Date" do
      expect(@daterange.start_date).must_be_kind_of Date
    end
  end

  describe "total_nights" do
    it "should return correct total of nights for given dates" do
      expect(@daterange.total_nights).must_equal 2
    end
  end

  describe "validate_date" do
    it "should return instance of DateRange if start_date and end_date are Date instances" do
      expect(@daterange).must_be_kind_of Hotel::DateRange
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
end