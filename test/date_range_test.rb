require_relative 'test_helper'

describe "Date Range class" do
  before do
    @data_range = Hotel::DateRange.new(
      start_date = Date.new(2010,03,02),
      end_date = Date.new(2010,03,05)
    )
    @date_range_two = Hotel::DateRange.new(
      start_date = Date.new(2010,03,8),
      end_date = Date.new(2010,03,10)
    )
    @date_range_three = Hotel::DateRange.new(
      start_date = Date.new(2010,03,8),
      end_date = Date.new(2010,03,10)
    )
  end

  it "is an instance of Date Range" do
    expect(@data_range).must_be_kind_of Hotel::DateRange
  end

  describe "overlap?" do
    it "will return false if the time is not overlapping" do
      expect(@date_range_two.overlap?(@data_range)).must_equal false
    end

    it "will return true if the time is overlapping" do
      expect(@date_range_two.overlap?(@date_range_three)).must_equal true
    end
  end
end
 