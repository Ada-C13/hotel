require "date"
require_relative "test_helper"

describe "DateRange class" do
  describe "DateRange instantiation" do
    before do
      @date_range = Hotel::DateRange.new(start_date: Date.new(2020, 2, 24), end_date: Date.new(2020, 3, 24))
    end
    describe "is an instance of DateRange" do
      it do
        expect(@date_range).must_be_kind_of Hotel::DateRange
      end
    end
    # tests for validating each parameter: start_date:, end_date:
  end
end
