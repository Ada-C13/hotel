require_relative "test_helper"
require 'date'


describe Hotel::HotelBlock do
  before do
    @room1 = Hotel::Room.new(1, 200)
    @room2 = Hotel::Room.new(2, 200)
    @room3 = Hotel::Room.new(3, 200)
    @room4 = Hotel::Room.new(4, 200)
    @room5 = Hotel::Room.new(5, 200)
    @room6 = Hotel::Room.new(6, 200)
    @room_array1 = [@room1, @room2]
    @room_array2 = [@room1,@room2,@room3,@room4,@room5,@room6]
    @room_array3 = []
    @start_date = Date.today
    @end_date = @start_date + 3
    @date_range = Hotel::DateRange.new(@start_date,@end_date)
    @discount_rate = 0.1 
  end
  describe "initailize HotelBlcok" do
    it "create an instance " do
      hotel_block = Hotel::HotelBlock.new(@date_range,@room_array1,@discount_rate) 
      expect(hotel_block).must_be_kind_of Hotel::HotelBlock
    end

    it "raise ArgumentError when the length of rooms_array is greater than 5" do
      expect{Hotel::HotelBlock.new(@date_range,@room_array2,@discount_rate)}.must_raise ArgumentError
    end

    it "raise ArgumentError when rooms is an empty array" do
      expect{Hotel::HotelBlock.new(@date_range,@room_array3,@discount_rate)}.must_raise ArgumentError
    end
  end
end