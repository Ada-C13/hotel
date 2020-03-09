require_relative 'test_helper'

describe "Room class" do
  describe "initialize" do 
    before do
      @room = Hotel::Room.new(
        room_num: 10
      )
    end 
  
    it "is an instance of Room" do
      expect(@room).must_be_kind_of Hotel::Room
    end

    it "has a cost of 200" do
      expect(@room.cost).must_equal 200
    end

    it "has a room_num of 10" do
      expect(@room.room_num).must_equal 10
    end

  end 

end 
