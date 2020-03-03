require_relative "test_helper"
require 'date'

describe Hotel::DateRange do


  describe "Initilize" do
    it "Can be initialized with two dates" do
      
      start_date = Date.new(2017, 01, 01)
      end_date = start_date + 3
      @range = Hotel::DateRange.new(start_date, end_date)

      expect(@range.start_date).must_equal @start_date
      expect(@range.end_date).must_equal @end_date
    end

    it "is an an error for negative-lenght ranges" do
      start_date = Date.new(2017, 01, 01)
      end_date = Date.new(2015, 01, 01)

      expect{
        Hotel::DateRange.new(start_date, end_date)
      }.must_raise ArgumentError

    end

    it "is an error to create a 0-length range" do

    end

    it "Raises an error for incorrect dates format" do
        start_date = Date.new(2017)
        end_date = Date.new(2)

        expect {
          Hotel::DateRange.validate_date(start_date)
        }.must_raise ArgumentError

        expect {
          Hotel::DateRange.validate_date(end_date)
        }.must_raise ArgumentError

    end
  end

  describe "overlap?" do
    before do
      start_date = Date.new(2017, 01, 01)
      end_date = start_date + 3
      @range = Hotel::DateRange.new(start_date, end_date)
    end

    it "returns true for the same range" do
      start_date = @range.start_date
      end_date = @range.end_date
      test_range = Hotel::DateRange.new(start_date, end_date)

      expect(@range.overlap?(test_range)).must_equal true
    end
  end
end