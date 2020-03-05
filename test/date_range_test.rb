require "date"
require_relative "test_helper"

describe "DateRange class" do
  describe "DateRange instantiation" do
    before do
      @date_range = Hotel::DateRange.new(check_in: Date.new(2020, 2, 24), check_out: Date.new(2020, 2, 25))
    end
    describe "is an instance of DateRange" do
      it do
        expect(@date_range).must_be_kind_of Hotel::DateRange
      end
    end
    # tests for validating each parameter: check_in:, check_out:
    # check for ArgumentError
  end
  # test for overlap?
  # test for include?
end
