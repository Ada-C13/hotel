require_relative "test_helper"

describe "DateRange" do
  describe "#initialize" do
    it "raise ArgumentError if end date is earlier than start date" do
      start_date = "2020-03-10"
      end_date = "2020-03-08"
      expect{ Hotel::DateRange.new(start_date, end_date) }.must_raise ArgumentError
    end
  end

  describe "self.all_dates" do
    it "list out all the dates of a provided time frame" do
      start_date = "2020-03-08"
      end_date = "2020-03-10"
      date_range = Hotel::DateRange.new(start_date, end_date)
      expect(date_range.all_dates).must_be_kind_of Array
      date_range = Hotel::DateRange.new(start_date, end_date)
      expect(date_range.all_dates.length).must_equal 3
    end
  end
end