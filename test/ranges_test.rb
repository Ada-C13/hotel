require_relative 'test_helper'

describe "Date Range" do
  describe "#initialize" do
    it "creates an instance of DateRange class" do
      expect(Hotel::DateRange.new(start_date: "3 Mar", end_date: "5 Mar")).must_be_instance_of Hotel::DateRange
    end

    it "raises an Argument Error if the end date is less than or equal to start date" do
      expect{Hotel::DateRange.new(start_date: "7 Mar 2020", end_date: "5 Mar 2020")}.must_raise ArgumentError
    end
  end
end
