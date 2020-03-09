require_relative 'test_helper'

describe "DateRange class" do
  describe "initialize" do

    before do
      @dates = Hotel::DateRange.new(Date.new, Date.new + 2)
    end

    it "creates an instance of DateRange" do
      expect(@dates).must_be_kind_of Hotel::DateRange
    end

    it "raises an error for invalid dates" do
      expect{(Hotel::DateRange.new(Date.new+2, Date.new))}.must_raise ArgumentError
    end

    it "returns accurate count of nights spent" do
      expect(@dates.nights_spent).must_equal 2
    end

    it "returns accurate start Date" do
      expect(@dates.check_in).must_be_kind_of Date
    end

  end

end