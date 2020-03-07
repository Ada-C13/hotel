require_relative 'test_helper'

describe "HotelBlock" do 

  describe "Initialize" do
    let(:start_date) { Date.new(2020, 5, 01)}
    let(:end_date) { Date.new(2020, 5, 05)}
    let(:range) { HotelBooking::DateRange.new(start_date: start_date, end_date: end_date) }

    let(:hotel_block) { HotelBooking::HotelBlock.new(name: "Wedding: Johnson-Poe", date_range: range, room_count: 4, discount_rate: 0.9) }
    
    it "creates a new instance of Hotel block" do
      expect(hotel_block).must_be_instance_of HotelBooking::HotelBlock
    end

    it "keeps track of date range " do
      expect(hotel_block).must_respond_to :date_range
      expect(hotel_block.date_range).must_be_instance_of HotelBooking::DateRange
    end

    it "keeps track of number of rooms in the hotel block" do
      expect(hotel_block).must_respond_to :room_count
      expect(hotel_block.room_count).must_be_kind_of Integer
    end

    it "keeps track of discount rate in the hotel block" do
      expect(hotel_block).must_respond_to :discount_rate
      expect(hotel_block.discount_rate).must_be_kind_of Numeric
    end
    
  end

end