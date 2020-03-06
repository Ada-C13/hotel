require_relative 'test_helper'

describe "HotelBlock" do
  describe "initialize HotelBlock" do

    before do
      @start_date = Date.today + 2
      @end_date = Date.today + 6
      @date_range = Hotel::DateRange.new(start_date: @start_date, end_date: @end_date)
    end

    it "creates a HotelBlock object" do
      expect(Hotel::HotelBlock.new(block_count: 3, date_range: @date_range, discount_cost: 180)).must_be_instance_of Hotel::HotelBlock
    end
    it "reserves the correct number of rooms" do
      
      expect(Hotel::HotelBlock.new(block_count: 3, date_range: @date_range, discount_cost: 180).rooms.count).must_equal 3
      expect(Hotel::HotelBlock.new(block_count: 2, date_range: @date_range, discount_cost: 180).rooms.count).must_equal 2
      expect(Hotel::HotelBlock.new(block_count: 4, date_range: @date_range, discount_cost: 180).rooms.count).must_equal 4
      expect(Hotel::HotelBlock.new(block_count: 5, date_range: @date_range, discount_cost: 180).rooms.count).must_equal 5
    
    end
  
    it "raises exception if block_count is not greater than 1 or less than 6" do
      expect{Hotel::HotelBlock.new(block_count: 6, date_range: @date_range, discount_cost: 180).rooms.count}.must_raise ArgumentError
      expect{Hotel::HotelBlock.new(block_count: 1, date_range: @date_range, discount_cost: 180).rooms.count}.must_raise ArgumentError
      expect{Hotel::HotelBlock.new(block_count: 0, date_range: @date_range, discount_cost: 180).rooms.count}.must_raise ArgumentError
      expect{Hotel::HotelBlock.new(block_count: -1, date_range: @date_range, discount_cost: 180).rooms.count}.must_raise ArgumentError
      expect{Hotel::HotelBlock.new(block_count: "three", date_range: @date_range, discount_cost: 180).rooms.count}.must_raise ArgumentError
    end
  
    it " raises exception if there aren't enough rooms to fill block" do
      
    end

    it "sets aside the rooms and doesn't allow someone out of the block to reserve a room in the block" do
      
    end
  end

  # describe "add_reservation_to_block" do

  #   it "reserves the correct number of rooms" do
    
  #   end
  
  #   it "raises exception if block_count is not greater than 1 or less than 6" do
      
  #   end
  
  #   it " raises exception if there aren't enough rooms to fill block" do
      
  #   end
  # end
end

