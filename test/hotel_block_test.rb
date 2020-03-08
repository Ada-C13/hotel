require_relative "test_helper"

describe "HotelBlock" do
  before do
    @date_range = Hotel::DateRange.new(Date.new(2020,5,3), Date.new(2020,5,5))
    @rooms = [2..4]
    @discount_rate = 0.15

    @hotel_block = Hotel::HotelBlock.new(@date_range, @rooms, @discount_rate)
  end

  describe "initialize" do
    it "creates an instance of HotelBlock" do
      expect(@hotel_block).must_be_kind_of Hotel::HotelBlock
      expect(@hotel_block).must_respond_to :date_range
      expect(@hotel_block).must_respond_to :rooms
      expect(@hotel_block).must_respond_to :discount_rate
    end

    it "raises ArgumentError if date_range is not instance of DateRange" do
      date_range = "tues-thurs"
      expect{ Hotel::DateRange.new(date_range, @rooms, @discount_rate) }.must_raise ArgumentError
    end
  end

  describe "calculate_discounted_rate" do
    
  end
end