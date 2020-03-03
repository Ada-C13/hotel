require_relative 'test_helper'

describe "Date Range" do 
  # did you see what I did here? it's our break week!
  # JK - I will be at home working.
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

    it "raises an argument error if the end date is before start date" do
      expect { HotelBooking::DateRange.new(start_date: Date.new(2020, 3, 27), end_date: Date.new(2020, 3, 23)) }.must_raise ArgumentError
    end

    it "raises an argument error if start date is in the past" do
      expect { HotelBooking::DateRange.new(start_date: Date.new(2019, 3, 27), end_date: Date.new(2020, 3, 23)) }.must_raise ArgumentError
    end
    
  end
end