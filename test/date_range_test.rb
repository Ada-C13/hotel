require_relative 'test_helper'

describe "Date Range class" do
  before do
    @data_range = Hotel::DateRange.new(
      start_date = Time.new(2010,03,02),
      end_date = Time.new(2010,03,05)
    )
  end

  it "is an instance of Date Range" do
    expect(@data_range).must_be_kind_of Hotel::DateRange
  end
end
