require_relative 'test_helper'

describe "DateRange" do
  describe "initialize" do
    it "raises ArgumentError if end date is before start date" do
      expect{Hotel::DateRange.new(start_date: "3/4/2020", end_date: "3/3/2020")}.must_raise ArgumentError
    end
  end
  
end