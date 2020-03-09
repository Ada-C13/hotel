require_relative 'test_helper'
require 'date'


describe "HotelBlock class" do

  describe "Initializer" do
    before do
      date_in1 = DateTime.new(2020,2,3.5)
      date_out1 = DateTime.new(2020,2,5.5)
      date_in2 = DateTime.new(2020,2,7.5)
      date_out2 = DateTime.new(2020,2,14.5)
      date_in3 = DateTime.new(2020,2,14.5)
      date_out3 = DateTime.new(2020,2,16.5)
      @block = Hotel::HotelBlock.new(date_in: date_in1,date_out: date_out1 ,number_of_rooms: (2..5), rooms_block:[],discounted_room_rate: 150)
    end
    
    it "is an instance of FrontDesk" do
      expect(@block).must_be_kind_of Hotel::HotelBlock
    end
  end
end