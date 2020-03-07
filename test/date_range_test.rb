require_relative 'test_helper'

describe "Date Range" do 
  # did you see what I did here? it's our break week!
  # JK - I will be at home, working on ada/personal projects.
  let(:start_date) { Date.new(2020, 3, 23)}
  let(:end_date) { Date.new(2020, 3, 27)}
  let(:date_range) { HotelBooking::DateRange.new(start_date: start_date, end_date: end_date) }

  describe "Initialize" do
    it "creates a new instance of DateRange" do
      expect(date_range).must_be_instance_of HotelBooking::DateRange
    end

    it "keeps track of start date as a instance of Date class" do
      expect(date_range).must_respond_to :start_date
      expect(date_range.start_date).must_equal start_date
      expect(date_range.start_date).must_be_instance_of Date
    end
    
    it "keeps track of start date as a instance of Date class" do
      expect(date_range).must_respond_to :end_date
      expect(date_range.end_date).must_equal end_date
      expect(date_range.end_date).must_be_instance_of Date
    end

    it "raises an argument error if the end date is before start date " do
      expect { HotelBooking::DateRange.new(start_date: Date.new(2020, 3, 27), end_date: Date.new(2020, 3, 23)) }.must_raise ArgumentError
    end

    it "raises an argument error if the end date is same as the start date " do
      expect { HotelBooking::DateRange.new(start_date: Date.new(2020, 3, 23), end_date: Date.new(2020, 3, 23)) }.must_raise ArgumentError
    end

    it "raises an argument error if start date is in the past" do
      expect { HotelBooking::DateRange.new(start_date: Date.new(2019, 3, 27), end_date: Date.new(2020, 3, 23)) }.must_raise ArgumentError
    end

    
    it "raises an argument error if the end date is not provided " do
      expect { HotelBooking::DateRange.new(start_date: Date.new(2020, 3, 23), end_date: nil ) }.must_raise ArgumentError
    end

  end

  describe "overlap?" do

    it "returns true for the same range" do
      test_range = HotelBooking::DateRange.new(start_date: Date.new(2020, 3, 23), end_date: Date.new(2020, 3, 27))

      expect(date_range.overlap?(test_range)).must_equal true
    end

    it "returns true for a contained range" do
      test_range = HotelBooking::DateRange.new(start_date: Date.new(2020, 3, 24), end_date: Date.new(2020, 3, 26))

      expect(date_range.overlap?(test_range)).must_equal true

    end

    it "returns true for a range that overlaps in front" do
      test_range = HotelBooking::DateRange.new(start_date: Date.new(2020, 3, 24), end_date: Date.new(2020, 3, 28))

      expect(date_range.overlap?(test_range)).must_equal true
    end

    it "returns true for a range that overlaps in the back" do
      test_range = HotelBooking::DateRange.new(start_date: Date.new(2020, 3, 22), end_date: Date.new(2020, 3, 26))

      expect(date_range.overlap?(test_range)).must_equal true
    end

    it "returns true for a containing range" do
      test_range = HotelBooking::DateRange.new(start_date: Date.new(2020, 3, 22), end_date: Date.new(2020, 3, 28))

      expect(date_range.overlap?(test_range)).must_equal true
    end

    it "returns false for a range starting on the end_date date" do
      test_range = HotelBooking::DateRange.new(start_date: Date.new(2020, 3, 20), end_date: Date.new(2020, 3, 23))

      expect(date_range.overlap?(test_range)).must_equal false
    end

    it "returns false for a range ending on the start_date date" do
      test_range = HotelBooking::DateRange.new(start_date: Date.new(2020, 3, 27), end_date: Date.new(2020, 3, 29))

      expect(date_range.overlap?(test_range)).must_equal false
    end

    it "returns false for a range completely before" do
      test_range = HotelBooking::DateRange.new(start_date: Date.new(2020, 3, 19), end_date: Date.new(2020, 3, 20))

      expect(date_range.overlap?(test_range)).must_equal false
    end

    it "returns false for a date completely after" do
      test_range = HotelBooking::DateRange.new(start_date: Date.new(2020, 3, 28), end_date: Date.new(2020, 3, 30))

      expect(date_range.overlap?(test_range)).must_equal false
    end
  end

  describe "include?" do
    it "reutrns false if the date is clearly out" do
      test_date_1 = Date.new(2020, 3, 20)
      test_date_2 = Date.new(2020, 3, 29)
      expect(date_range.include?(test_date_1)).must_equal false
      expect(date_range.include?(test_date_2)).must_equal false
    end

    it "returns false for the end_date date" do
      test_date = Date.new(2020, 3, 27)
      expect(date_range.include?(test_date)).must_equal false
    end
    
    it "returns true for dates in the range" do
      test_date = Date.new(2020, 3, 25)
      expect(date_range.include?(test_date)).must_equal true
    end
  end

  describe "nights" do
    it "returns the correct number of nights" do
      stay_nights = date_range.nights
      expect(stay_nights).must_equal 4
      expect(stay_nights).must_be_kind_of Integer
    end
  end

end