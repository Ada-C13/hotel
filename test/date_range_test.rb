require_relative 'test_helper'

describe "DateRange class" do
  describe "initialize" do

    before do
      check_in = Date.parse('2020-08-01')
      check_out = Date.parse('2020-08-04')

      @dates = Hotel::DateRange.new(check_in, check_out)
    end

    it "creates an instance of DateRange" do
      expect(@dates).must_be_kind_of Hotel::DateRange
    end

    it "returns accurate count of nights spent" do
      expect(@dates.nights_spent).must_equal 3
    end

    it "returns accurate start Date" do
      expect(@dates.check_in).must_be_kind_of Date

    end

  end

end