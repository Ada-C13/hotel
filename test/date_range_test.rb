require_relative 'test_helper'
require 'date'

describe "DateRange" do
  describe "#initialize" do
    it "Creates an instance of DateRange" do 
      start_date = Date.new(2020, 3, 1)
      end_date = Date.new(2020, 3, 5)
  
      date_range = Hotel::DateRange.new(start_date, end_date)
      expect(date_range).must_be_kind_of Hotel::DateRange
    end

    it "Keeps track of start_date" do
      start_date = Date.new(2020, 3, 1)
      end_date = Date.new(2020, 3, 5)
  
      date_range = Hotel::DateRange.new(start_date, end_date)
      expect(date_range).must_respond_to :start_date
      expect(date_range.start_date).must_be_kind_of Date
      expect(date_range.start_date).must_equal start_date
    end

    it "Keeps track of end_date" do
      start_date = Date.new(2020, 3, 1)
      end_date = Date.new(2020, 3, 5)
  
      date_range = Hotel::DateRange.new(start_date, end_date)
      expect(date_range).must_respond_to :end_date
      expect(date_range.end_date).must_be_kind_of Date
      expect(date_range.end_date).must_equal end_date
    end

    it "Raises an exception for invalid date range" do
      start_date = Date.new(2020, 3, 4)
      end_date = Date.new(2020, 3, 2)

      expect{
        Hotel::DateRange.new(start_date, end_date)
      }.must_raise ArgumentError
    end

    it "Raises an exception for invalid start/end date types" do
      start_date = "2020, 3, 1"
      end_date = "2020, 3, 5"

      expect{
        Hotel::DateRange.new(start_date, end_date)
      }.must_raise ArgumentError
    end
  end

  describe "#nights" do
    it "Returns the number of nights between start and end dates" do
      start_date = Date.new(2020, 3, 1)
      end_date = Date.new(2020, 3, 5)
  
      date_range = Hotel::DateRange.new(start_date, end_date)
      expect(date_range.nights).must_be_kind_of Integer
      expect(date_range.nights).must_equal 4
    end
  end
end
