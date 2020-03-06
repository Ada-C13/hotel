require_relative 'test_helper'

describe "HotelBlock" do
  before do
    @start_date = Date.today + 2
    @end_date = Date.today + 6
    @date_range = Hotel::DateRange.new(start_date: @start_date, end_date: @end_date)
  end

  describe "initialize HotelBlock" do

    it "creates a HotelBlock object" do
      expect(Hotel::HotelBlock.new(block_count: 3, date_range: @date_range, discount_cost: 180)).must_be_instance_of Hotel::HotelBlock
    end
   
    it "raises exception if block_count is not greater than 1 or less than 6" do
      expect{Hotel::HotelBlock.new(block_count: 6, date_range: @date_range, discount_cost: 180).rooms.count}.must_raise ArgumentError
      expect{Hotel::HotelBlock.new(block_count: 1, date_range: @date_range, discount_cost: 180).rooms.count}.must_raise ArgumentError
      expect{Hotel::HotelBlock.new(block_count: 0, date_range: @date_range, discount_cost: 180).rooms.count}.must_raise ArgumentError
      expect{Hotel::HotelBlock.new(block_count: -1, date_range: @date_range, discount_cost: 180).rooms.count}.must_raise ArgumentError
      expect{Hotel::HotelBlock.new(block_count: "three", date_range: @date_range, discount_cost: 180).rooms.count}.must_raise ArgumentError
    end
  
    

  end


  # describe "change_block_status" do

  #   it "changes the block status of the found room" do
  #     expect(Hotel::HotelBlock.new(block_count: 3, date_range: @date_range.rooms[0], discount_cost: 180).block_status).must_equal :in_block
  #     expect(Hotel::HotelBlock.new(block_count: 3, date_range: @date_range.rooms[1], discount_cost: 180).block_status).must_equal :in_block
  #     expect(Hotel::HotelBlock.new(block_count: 3, date_range: @date_range.rooms[2], discount_cost: 180).block_status).must_equal :in_block
  #   end

  # end
  # describe "add_reservation_to_block" do

  #   it "reserves the correct number of rooms" do
    
  #   end
  
  #   it "raises exception if block_count is not greater than 1 or less than 6" do
      
  #   end
  
  #   it " raises exception if there aren't enough rooms to fill block" do
      
  #   end
  # end
end

