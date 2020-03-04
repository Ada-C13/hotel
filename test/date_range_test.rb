require_relative "test_helper"

describe "DateRange class" do
  describe "DateRange instatiation" do
    # before do
    #   date_range = Hotel::DateRange.new()
    # end
    it "is an instance of DateRange" do
      expect(Hotel::DateRange.new(start_date: "2020-3-1", end_date: "2020-3-10")).must_be_kind_of Hotel::DateRange
    end

    it "converts its start_date and end_date attributes to Date objects" do
      date_range = Hotel::DateRange.new(start_date: "2020-3-1", end_date: "2020-3-10")
      expect(date_range.start_date).must_be_kind_of Date
      expect(date_range.end_date).must_be_kind_of Date
    end 

    it "raises an ArgumentError if end_date is equal to or comes before start_date" do
      expect {Hotel::DateRange.new(start_date: "2020-3-1", end_date: "2020-2-10")}.must_raise ArgumentError
      expect {Hotel::DateRange.new(start_date: "2020-3-1", end_date: "2020-3-1")}.must_raise ArgumentError
    end

    # TODO
    # it "can be instantiated with no arguments" do
    #   expect(Hotel::DateRange.new()).must_be_kind_of Hotel::DateRange
    # end
  end

  describe "overlap?" do
    let (:date_range) {
      Hotel::DateRange.new(start_date: "2020-3-1", end_date: "2020-3-20")
    }

    it "expects a DateRange as an argument" do
      expect {date_range.overlap?(50)}.must_raise ArgumentError
    end

    it "returns true if the dates overlap and false if not" do
      # TODO: each one should be a new test?
      second_date_range = Hotel::DateRange.new(start_date: "2020-3-2", end_date: "2020-3-10")
      expect(date_range.overlap?(second_date_range)).must_equal true

      third_date_range = Hotel::DateRange.new(start_date: "2020-3-13", end_date: "2020-3-25")
      expect(date_range.overlap?(third_date_range)).must_equal true

      forth_date_range = Hotel::DateRange.new(start_date: "2020-2-10", end_date: "2020-2-26")
      expect(date_range.overlap?(forth_date_range)).must_equal false

      fifth_date_range = Hotel::DateRange.new(start_date: "2020-3-23", end_date: "2020-3-25")
      expect(date_range.overlap?(fifth_date_range)).must_equal false

      six_date_range = Hotel::DateRange.new(start_date: "2020-3-20", end_date: "2020-3-21")
      expect(date_range.overlap?(six_date_range)).must_equal false
    end

    # TODO:
    # it "expects a DateRange provided as an argument to have start_date and end_date rather than nil" do
    #   other_date_range_1 = Hotel::DateRange.new(end_date: "2020-5-10")
    #   expect {date_range.overlap? (other_date_range_1)}.must_raise ArgumentError

    #   other_date_range_2 = Hotel::DateRange.new(start_date: "2020-5-10")
    #   expect {date_range.overlap? (other_date_range_2)}.must_raise ArgumentError
    # end
  end

end