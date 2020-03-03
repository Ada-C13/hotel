require_relative "test_helper"

describe "DateRange" do
  before do
    @daterange = Hotel::DateRange.new(Date.new(2001,2,3), Date.new(2001,2,5))
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
end