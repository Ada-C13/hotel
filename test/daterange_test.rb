require_relative 'test_helper'

describe "DateRange Class" do
  before do
    start_date = Date.today + 5
    end_date = Date.today + 10
  
    @range01 = Hotel::DateRange.new(start_date, end_date)
  end

  describe "Initialize" do
    
    it "Is an instance of DateRange" do
      expect(@range01).must_be_kind_of Hotel::DateRange
    end

    it "Stores a start date that is a Date class" do
      expect(@range01.start_date).must_be_kind_of Date
    end

    it "Stores an end date that is a Date class" do
      expect(@range01.end_date).must_be_kind_of Date
    end

    it "raises an ArgumentError if end date is before start date" do
      start_date = Date.today + 5
      end_date = Date.today + 1
      expect{Hotel::DateRange.new(start_date, end_date)}.must_raise ArgumentError
    end

    it "raises ArgumentError if start_date or end_date is not a Date class" do
      start_date = Date.today + 10
      end_date = Date.today + 15
      expect{Hotel::DateRange.new("2020/03/25", end_date)}.must_raise ArgumentError
      expect{Hotel::DateRange.new(start_date, 20200327)}.must_raise ArgumentError
    end

    it "raises ArgumentError if start_date is in the past" do
      start_date = Date.today - 5
      end_date = Date.today + 1
      expect{Hotel::DateRange.new(start_date, end_date)}.must_raise ArgumentError
    end

    it "raises ArgumentError for a 0-length date range" do
      start_date = Date.today
      end_date = start_date
      expect{Hotel::DateRange.new(start_date, end_date)}.must_raise ArgumentError
    end

  


  end

  describe "count_nights" do
    it "counts the total nights of stay within a date range" do
      expect(@range01.count_nights).must_equal 5
    end
  end
end


# before do
#   start_year = 2020
#   start_month = 03
#   start_day = 25
#   end_year = 2020 
#   end_month = 03 
#   end_day = 27
#   @range01 = Hotel::DateRange.new(
#     start_year: start_year, start_month: start_month, start_day: start_day, 
#     end_year: end_year, end_month: end_month, end_day: end_day)
# end

